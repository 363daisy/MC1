//
//  ResultView.swift
//  TourBuddy
//
//  Created by NANA on 3/24/24.
//

import SwiftUI

struct ResultView: View {
    
    @Binding var progressValue1: Float
    @Binding var progressValue2: Float
    @Binding var progressValue3: Float
    @Binding var progressValue4: Float
    @State private var isAnimated = false
    @State private var dragOffset: CGSize = .zero
    @State var isActive: Bool = false
    @State var userTotal: Float = 0
    @State var npcTotal: Float = 0
    @State var userName: String = ""
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Image("belt").resizable().frame(width: 352, height: 900)
                ZStack{
                    ScrollView{
                        
                        VStack{
                            suitCase( progressValue1: $progressValue1, progressValue2: $progressValue2, progressValue3: $progressValue3, progressValue4: $progressValue4, userName: "나나").rotationEffect(.degrees(30))
                                .padding(.bottom, 50)
                        
                            Button{
                                isActive = true
                                userName = "돌돌이"
                                npcTotal=11
                            }label: {
                                suitCaseDefalut(value1: 0.1, value2: 0.3, value3: 0.2, value4: 0.5, isActive: $isActive, name: "돌돌이"  ).rotationEffect(.degrees(-10))

                            }
                            
                            
                            Button{
                                isActive=true
                                userName = "찍찍이"
                                npcTotal=11
                            }label: {
                                suitCaseDefalut(value1: 0.3, value2: 0.4, value3: 0.3, value4: 0.1, isActive: $isActive, name: "찍찍이").rotationEffect(.degrees(20))
                                    .padding(.bottom, 50)
                            }
                            Button{
                                isActive=true
                                userName = "짹짹이"
                                npcTotal=10
                            }label: {
                                suitCaseDefalut(value1: 0.2, value2: 0.3, value3: 0.1, value4: 0.4, isActive: $isActive, name: "짹짹이").rotationEffect(.degrees(-20))
                                    .padding(.bottom, 50)
                            }
                            NavigationLink(destination: ResultDetailView()){
                                Text("자세히보기")
                                    .font(.custom("SangSangShinb7OTF", size: 20))
                                    .frame(width: 120, height: 20)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(hex: "#B9E7FF"))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                                    ).offset(y:40)
                            }
                            NavigationLink(destination: RetrospectView()){
                                Text("회고하기")
                                    .font(.custom("SangSangShinb7OTF", size: 20))
                                    .frame(width: 120, height: 20)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(hex: "#B9E7FF"))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                                    ).offset(y:40)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity) // 최소 너비부터 최대 너비까지 확장
                        //                    .padding(.top, 500)
                            .padding(.vertical, 200)
                            .offset(y: isAnimated ? 0 : 1050) // 애니메이션 적용
                            .offset(y: dragOffset.height) // 드래그 효과 적용
                    }
                    
                    // 애니메이션 트리거
                    
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.linear(duration: 3)) {
                                isAnimated = true
                            }
                        }
                        userTotal = progressValue1 + progressValue2 + progressValue3 + progressValue4
                        
                    }
                    
                    
                    
                    //
                    VStack(alignment: .leading, spacing: 5){
                        Text("얼마나 잘 맞을까?").foregroundColor(.white).font(.custom("SangSangShinb7OTF", size: 20))
                            .padding(.all, 7)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                        Text("버디들의 결과를 한눈에.").foregroundColor(.white)
                            .font(.custom("SangSangShinb7OTF", size: 30))
                            .bold()
                            .padding(.all, 8)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                    }
                    .navigationBarBackButtonHidden()
                    .padding(.top, -370)
                    
                }
                
            }.sheet(isPresented: $isActive) {
                
               // isActive에 따라 시트가 표시됨
                BuddyDialog(isActive: $isActive, title: "- 여행계획편 -", message: "98", buttonTitle: "확인", totalProgress: 0.0, npcName: userName) {
                    print("Pass to viewModel")
                }
            }
        }
    }
}

struct suitCase: View{
    @Binding var progressValue1: Float
    @Binding var progressValue2: Float
    @Binding var progressValue3: Float
    @Binding var progressValue4: Float
    
    var userName: String
    var body: some View{
        ZStack{
            Image("suitcase").resizable().frame(width: 220, height: 344)
                .shadow(radius: 40)
            VStack{
                Text(userName).font(.custom("SangSangShinb7OTF", size: 30)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).bold()
                Gauge(value: self.progressValue1, in: 0...0.5, label: {
                    Text("계획").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                   
                Gauge(value: self.progressValue2, in: 0...0.5, label: {
                    Text("돈").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                Gauge(value: self.progressValue3, in: 0...0.5, label: {
                    Text("체력").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                Gauge(value: self.progressValue4, in: 0...0.5, label: {
                    Text("모험").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
            } .padding(.bottom, 5)
            
        }
    }
}

struct suitCaseDefalut: View{
    @State var value1: Float
    @State var value2: Float
    @State var value3: Float
    @State var value4: Float
    @Binding var isActive: Bool
    @State var name: String
    var body: some View{
        ZStack{
            Image("suitcase").resizable().frame(width: 220, height: 344)
                .shadow(radius: 40)
            VStack{
                Text(name).font(.custom("SangSangShinb7OTF", size: 30)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).bold()
                Gauge(value: self.value1, in: 0...0.5, label: {
                    Text("계획").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                   
                Gauge(value: self.value2, in: 0...0.5, label: {
                    Text("돈").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                Gauge(value: self.value3, in: 0...0.5, label: {
                    Text("체력").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
                Gauge(value: self.value4, in: 0...0.5, label: {
                    Text("모험").font(.custom("SangSangShinb7OTF", size: 20)).offset(y:10)
                }).frame(width:150, height: 40)
            } .padding(.bottom, 5)
            
        }
    }
}

#Preview {
    ResultView(progressValue1: .constant(0), progressValue2: .constant(0), progressValue3: .constant(0), progressValue4: .constant(0))
}
