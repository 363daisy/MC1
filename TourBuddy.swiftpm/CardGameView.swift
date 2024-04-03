//
//  CardGameView.swift
//  TourBuddy
//
//  Created by NANA on 3/23/24.
//

import SwiftUI

struct CardGameView: View {
    @State var progressValue1: Float = 0.0
    @State var progressValue2: Float = 0.0
    @State var progressValue3: Float = 0.0
    @State var progressValue4: Float = 0.0
    @State private var removalTransition = AnyTransition.trailingBottom
        
        private let dragThreshold: CGFloat = 80.0
        
        enum DragState {
            case inactive
            case pressing
            case dragging(translation: CGSize)
            
            var translation: CGSize {
                switch self {
                case .inactive, .pressing:
                    return .zero
                case .dragging(let translation):
                    return translation
                }
            }
            
            var isDragging: Bool {
                switch self {
                case .dragging:
                    return true
                case .pressing, .inactive:
                    return false
                }
            }
            
            var isPressing: Bool {
                switch self {
                case .pressing, .dragging:
                    return true
                case .inactive:
                    return false
                }
            }
        }
        
        @GestureState private var dragState = DragState.inactive
        
        
        @State private var lastIndex = 1
        
        @State var cardViews: [CardView] = {
            
            var views = [CardView]()
            
            for index in 0..<2 {
                views.append(CardView(title: Questions[index].title))
            }
            
            return views
        }()
    
    
    @State private var gaugeValue: Double = 0 // 게이지 바의 값을 나타내는 상태 변수
    @State private var imageOffsetY: CGFloat = 25 // 이미지의 수직 위치를 나타내는 상태 변수
    @State private var showResult = false // ResultView를 표시할지 여부를 나타내는 상태 변수
    @State private var i: Int = 0 //인덱스
    
    var body: some View{
        NavigationStack{
            VStack {
                TopStateMenu(progressValue1: $progressValue1, progressValue2: $progressValue2, progressValue3: $progressValue3, progressValue4: $progressValue4).padding(.top,30)
                NavigationLink(destination: ResultView(progressValue1: $progressValue1, progressValue2: $progressValue2, progressValue3: $progressValue3, progressValue4: $progressValue4), isActive: $showResult) {
                    EmptyView()
                }
                .hidden() // 숨겨진 네비게이션 링크
                GeometryReader { geometry in
                    ZStack(alignment: .topLeading) {
                        Gauge(value: gaugeValue, in: 0...10, label: {
                            Text("")
                        })
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        
                        Image("Logo") // 이동하는 이미지
                        //                                    .foregroundColor(.red)
                            .resizable()
                            .frame(width: 32, height: 33)
                            .padding(.top, 12)
                            .padding(.leading, imageOffsetY)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    .background(Color.clear)
                    
                }
                ZStack {
                    ForEach(cardViews) { cardView in
                        cardView
                            .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                            .overlay(
                                ZStack {
                                    Image(systemName: "x.circle")
                                        .foregroundColor(.red)
                                        .font(.system(size: 100))
                                        .opacity(self.dragState.translation.width < -self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
                                    
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(.green)
                                        .font(.system(size: 100))
                                        .opacity(self.dragState.translation.width > self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
                                }
                            )
                        
                        
                            .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                            .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0)
                            .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 10) : 0))
                            .animation(.interpolatingSpring(stiffness: 180, damping: 100))
//                                                        withAnimation {
//                                                            interpolatingSpring(stiffness: 180, damping: 100)
//                        //                                }
                            .transition(self.removalTransition)
                            .gesture(LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                    .onChanged({ (value) in
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        if drag.translation.width < -self.dragThreshold {
                                            self.removalTransition = .leadingBottom
                                            
                                        }
                                        
                                        if drag.translation.width > self.dragThreshold {
                                            self.removalTransition = .trailingBottom
                                           
                                        }
                                    })
                                     
                                        .onEnded({ (value) in
                                            guard case .second(true, let drag?) = value else {
                                                return
                                            }
                                            if drag.translation.width < -self.dragThreshold || drag.translation.width > self.dragThreshold {
                                                if drag.translation.width > self.dragThreshold {
                                                            // 카드가 오른쪽으로 드래그되었을 때
                                                    self.progressValue1 += Questions[i].score1
                                                    self.progressValue2 += Questions[i].score2
                                                    self.progressValue3 += Questions[i].score3
                                                    self.progressValue4 += Questions[i].score4
                                                        }
                                                self.moveCard()
                                            }
                                        })
                            )
                    }
                }
                
                Spacer(minLength: 20)
                BottomBarMenu()
                    .opacity(dragState.isDragging ? 0.0 : 1.0)
                    .animation(.default)
            }
            .onAppear {
                // 게이지 값이 10에 도달할 때까지 1씩 증가하면서 게이지와 이미지 이동
                //                        withAnimation(.linear(duration: 5)) { // 애니메이션 속도 및 이동 시간 조절 가능
                //                            gaugeValue = 10
                //                        }
                
            }
            
        }
    }
    private func isTopCard(cardView: CardView) -> Bool {
            guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
                return false
            }
            return index == 0
        }
        
        private func moveCard() {
            cardViews.removeFirst()
            
            self.lastIndex += 1
            let profile = Questions[lastIndex % Questions.count]
            
            let newCardView = CardView(title: profile.title)
            withAnimation(Animation.linear(duration: 0.5)) {
                imageOffsetY += 33
                if gaugeValue < 10 { // gaugeValue가 10 미만일 때만 증가
                    gaugeValue += 1 // gaugeValue를 1 증가시킴
                    i += 1
                    
//                    print(gaugeValue)
                        }
                if gaugeValue >= 10{
//                    print("success")
                    showResult=true
                }
            }
            
            
            cardViews.append(newCardView)
        }
    
    }


//struct ProgressBar: View{
//    @Binding var progressValue: Float
//    var color: Color = Color.graphRed
//    
//    var body: some View{
//
//    }
//}
struct TopStateMenu: View{
    @Binding var progressValue1: Float
    @Binding var progressValue2: Float
    @Binding var progressValue3: Float
    @Binding var progressValue4: Float
    var body: some View{
        HStack{
            ZStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 8.0)
                        .opacity(0.20)
                        .foregroundColor(Color.gray)
                    Circle()
                        .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(min(self.progressValue1*2, 0.5)))
                        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.graphRed)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2.0))
                }
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 30)
                Image("state_plan")
                    .resizable()
                    .frame(width: 82, height: 90)
            }
            Spacer()
            ZStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 8.0)
                        .opacity(0.20)
                        .foregroundColor(Color.gray)
                    Circle()
                        .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(min(self.progressValue2*2, 0.5)))
                        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.graphRed)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2.0))
                }
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 30)
                Image("state_money")
                    .resizable()
                    .frame(width: 82, height: 90)
            }
            Spacer()
            ZStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 8.0)
                        .opacity(0.20)
                        .foregroundColor(Color.gray)
                    Circle()
                        .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(min(self.progressValue3*2, 0.5)))
                        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.graphRed)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2.0))
                }
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 30)
                Image("state_hp")
                    .resizable()
                    .frame(width: 82, height: 90)
            }
            Spacer()
            ZStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 8.0)
                        .opacity(0.20)
                        .foregroundColor(Color.gray)
                    Circle()
                        .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(min(self.progressValue4*2, 0.5)))
                        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.graphRed)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2.0))
                }
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 30)
                Image("state_adventure")
                    .resizable()
                    .frame(width: 82, height: 90)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct CardView: View, Identifiable{
    let title: String
    
    let id = UUID()
    var body: some View{
        //이미지 자리
        Image("gameScreen")
            .resizable()
                .frame(width: 315, height: 420)
                .shadow(radius: 2)
                .overlay(
                    VStack{
                        Text(title)
                            .font(.system(size: 26, weight: .bold, design: .rounded)) // 폰트 크기 조정
                            .multilineTextAlignment(.trailing)
                            .frame(width: 240)
                            .lineSpacing(20)
                            .foregroundColor(.gameYellow)
                            .fontWeight(.bold)
                            .padding(.top, 40)
                            .padding(.leading, 30)
                            
//                            .background(Color.white)
//                            .cornerRadius(5)
                    }
                        .padding(.top, 100)
                    , alignment: .top
                        
                )
    }
}

struct BottomBarMenu: View{
    var body: some View{
        HStack{
            
            Image(systemName: "xmark")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .padding(.leading, 40)
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundColor(.green)
                .padding(.trailing, 40)
        }
        
        .padding(.vertical, 30)
        
        
    }
}

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom))
        )
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
}

#Preview {
    Group{
        CardGameView()
    }
    
}
