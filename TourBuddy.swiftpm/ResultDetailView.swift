//
//  ResultDetailView.swift
//  TourBuddy
//
//  Created by NANA on 3/26/24.
//

import SwiftUI

struct ResultDetailView: View {
    var body: some View {
        Box()
    }
}
struct Box: View{
    var body: some View{
        ZStack{
            VStack{
                Text("여행계획편")
                    .font(.custom("SangSangShinb7OTF", size: 30))
                    .padding(.trailing,190)
                HStack{
                    Text("나나")
                        .frame(width: 40, height: 15)
                        .font(.custom("SangSangShinb7OTF", size: 22))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(hex: "#B9E7FF"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                            )
                    Text("돌돌")
                        .frame(width: 40, height: 15)
                        .font(.custom("SangSangShinb7OTF", size: 22))
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                            )
                    Text("찍찍")
                        .frame(width: 40, height: 15)
                        .font(.custom("SangSangShinb7OTF", size: 22))
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                            )
                    Text("짹짹")
                        .frame(width: 40, height: 15)
                        .font(.custom("SangSangShinb7OTF", size: 22))
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                            )
                }
                VStack(spacing: 10){
                    Text("Q1. 나는 철저하게 계획을 세우고 그대로 가고 싶어").frame(width: 370)
                        
                    Text("X").foregroundColor(.red).bold()
                    Text("Q2. 나는 공금을 만들어서 사용하고 싶어.").multilineTextAlignment(.leading)
                        .frame(width: 350, height: 60)
                    Text("O").foregroundColor(.red).bold()
                    Text("Q3. 여행을 즐겁게 하기 위해서는 우리만의 규칙이 필요해")
                    
                        .frame(width: 370, height: 60)
                    Text("O").foregroundColor(.red).bold()
                    
                    Text("Q4. 돈이 남더라도 환전은 여유롭게 해야돼")
                        .frame(width: 370, height: 60)
                    Text("X").foregroundColor(.red).bold()
                    Text("Q5. 가고 싶은 곳이 다르다면 따로 움직여도 괜찮아")
                        
                    Text("O").foregroundColor(.red).bold()
                    Text("Q6. 여기까지 왔는데 본전은 뽑아야지. 나는 많이 돌아다니고 싶어.")
                        .frame(width: 370, height: 60)
                    Text("O").foregroundColor(.red).bold()
                    Text("Q7. 내 시간은 소중해. 비싸더라도 고가항공을 이용할래")
                        .frame(width: 370, height: 60)
                    Text("X").foregroundColor(.red).bold()
                    
                }.padding(.top,20)
            }
        }
    }
}

#Preview {
    ResultDetailView()
}
