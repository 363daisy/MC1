//
//  ContentView.swift
//  TourBuddy
//
//  Created by NANA on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var yOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                ZStack{
                    Image(systemName: "paperplane").resizable().frame(width: 25, height: 25).offset(x: 110, y: -150)
                        .offset(x: yOffset + 3, y: -yOffset)
                        .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: yOffset)
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 240, height: 248)
                        .offset(x: 0, y: yOffset)
                        .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: yOffset)
                        
                    Image(systemName: "paperplane").resizable().frame(width: 25, height: 25).offset(x: -130, y: 180)
                        .offset(x: yOffset + 3, y: -yOffset)
                        .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: yOffset)
                }.onAppear {
                    withAnimation {
                        yOffset = 10
                    }
                }
                
                
                Text("투어버디").font(.custom("SangSangShinb7OTF", size: 70))
                
                NavigationLink(destination: EntryView()) {
                    Text("출발")
                        .font(.custom("SangSangShinb7OTF", size: 30))
                        .foregroundColor(Color.black)
                        .bold()
                        .font(.system(size: 14))
                        .frame(width: 180, height: 25)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "#B9E7FF"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                        )
                        
                    
                }
                    
            }
        }
    }
}


#Preview {
    
    ContentView()
}
