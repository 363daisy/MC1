//
//  CategoryVeiw.swift
//  TourBuddy
//
//  Created by NANA on 3/24/24.
//
//
//  CategoryVeiw.swift
//  TourBuddy
//
//  Created by NANA on 3/24/24.
//
import SwiftUI

struct CategoryView: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let images: [String] = ["category", "category2", "category3", "category4"]
    @State private var isContentPageActive = false // 추가
    
    var body: some View {
        
        NavigationStack { // NavigationView 추가
            
            VStack{
                Text("버디의").font(.custom("SangSangShinb7OTF", size: 30))
                Text("어떤 여행 스타일을").font(.custom("SangSangShinb7OTF", size: 40))
                Text("알고싶나요?")
                    .font(.custom("SangSangShinb7OTF", size: 30))
                    .multilineTextAlignment(.center).padding(.bottom, 60.0)
                ZStack {
                    
                    
                    ForEach(0..<images.count, id: \.self) { index in
                        NavigationLink {
                            CardGameView()
                        } label: {
                            Image(images[index])
                                .resizable()
                                .frame(width: 310, height: 426)
                                .scaleEffect(CGSize(width: 0.8, height: 0.8))
                                .opacity(currentIndex == index ? 1.0 : 0.0)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * 100 + dragOffset, y: -40)
                        }
                    }
                
                .gesture(
                    DragGesture()
                        .onEnded ({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(images.count - 1, currentIndex + 1)
                                }
                            }
                        })
                    )
                }
                
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } label: {
                                Image(systemName: "arrowshape.left.circle")
                                    .font(.title)
                            }
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    currentIndex = min(images.count - 1, currentIndex + 1)
                                }
                            } label: {
                                Image(systemName: "arrowshape.right.circle")
                                    .font(.title)
                            }
                        }
                    }
                }
            }
        }
//        }
    }
}





#Preview {
    CategoryView()
}
