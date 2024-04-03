//
//  RetrospectView.swift
//  TourBuddy
//
//  Created by NANA on 3/27/24.
//

import SwiftUI

struct RetrospectView: View {
    var body: some View {
        VStack{
            Text("오늘 하루는 어땠나요?")
                .font(.custom("SangSangShinb7OTF", size: 35))
                .padding(.trailing,30)
            Image("smile")
                .resizable().frame(width: 120, height: 120)
                .padding(.bottom, 20)
            Text("만족스러운 하루를 보내셨네요!").bold()
                .font(.custom("SangSangShinb7OTF", size: 25))
                .padding(.bottom, 20)
            Text("만족도").bold().font(.custom("SangSangShinb7OTF", size: 35))
            ZStack{
                Rectangle().frame(width: 250, height: 1).foregroundColor(.red)
                HStack{
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.red)
                        
                        Circle().frame(width: 15, height: 15)
                        .foregroundColor(.red).padding(.horizontal, 100)
                       
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.red)
                    
                }
            }
            HStack{
                Text("그저그래").font(.system(size: 14))
                    .padding(.trailing, 60)
                Text("그냥쏘쏘").font(.system(size: 14))
                    
                Text("너무좋아!").font(.system(size: 14))
                    .padding(.leading, 60)
            }.padding(.top, 4)
            Text("체력").bold().font(.custom("SangSangShinb7OTF", size: 35))
                .padding(.top, 10)
            ZStack{
                Rectangle().frame(width: 250, height: 1).foregroundColor(.red)
                HStack{
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.red)
                        
                        Circle().frame(width: 15, height: 15)
                        .foregroundColor(.red).padding(.horizontal, 100)
                       
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.red)
                    
                }
            }
            HStack{
                Text("힘들어요").font(.system(size: 14))
                    .padding(.trailing, 60)
                Text("보통이에요").font(.system(size: 14))
                    
                Text("팔팔해요!").font(.system(size: 14))
                    .padding(.leading, 60)
            }.padding(.top, 4)
            Text("소비").bold().font(.custom("SangSangShinb7OTF", size: 35))
                .padding(.top, 10)
            ZStack{
                Rectangle().frame(width: 250, height: 1).foregroundColor(.gray)
                Rectangle().frame(width: 130, height: 1).foregroundColor(.red)
                    .padding(.trailing,120)
                HStack{
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.red)
                        
                        Circle().frame(width: 15, height: 15)
                        .foregroundColor(.red).padding(.horizontal, 100)
                       
                        Circle().frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    
                }
            }
            HStack{
                Text("조금사용    ").font(.system(size: 14))
                    .padding(.trailing, 60)
                    .foregroundColor(.red)
                Text("보통  ").font(.system(size: 14))
                    .foregroundColor(.red)
                Text("많이사용").font(.system(size: 14))
                    .padding(.leading, 60)
            }.padding(.top, 4)
                }
    }
}

#Preview {
    RetrospectView()
}
