//
//  BuddyDialog.swift
//  TourBuddy
//
//  Created by NANA on 3/25/24.
//

import SwiftUI
 
struct BuddyDialog: View {
    @Binding var isActive: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let totalProgress: Float
    var npcName: String
        let action: () -> ()
       
        @State private var offset: CGFloat = 0

        var body: some View {
            ZStack {
//                Color(.black)
//                    .opacity(0.5)
//                    .onTapGesture {
//                        close()
//                    }

                VStack {
                    Image("logoTitle").resizable()
                        .frame(width: 250, height: 80)
                        .padding(.bottom, 10)
                    Text(title)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 30)
//                    Text(message)
//                        .font(.body)
                    Text("나나님과 \(npcName)님은 70% 일치합니다.")
                        .font(.custom("SangSangShinb7OTF", size: 40))
                        .padding(.bottom,40)

                    Button {
                        action()
                        close()
                    } label: {
                        ZStack {
                           
                            Text(buttonTitle)
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
                        .padding()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(.white)
                
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .overlay(alignment: .topTrailing) {
//                    Button {
//                        close()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .font(.title2)
//                            .fontWeight(.medium)
//                    }
//                    .tint(.black)
//                    .padding()
//                }
//                .shadow(radius: 20)
                .padding(30)
                .offset(x: 0, y: offset)
//                .onAppear {
//                    withAnimation(.spring()) {
//                        offset = 0
//                    }
//                }
            }
            .ignoresSafeArea()
        }

        func close() {
            withAnimation(.spring()) {
                isActive = false
                offset = 1000
                
            }
        }
        
}

#Preview {
    BuddyDialog(isActive: .constant(true), title: "계획 항공편", message:"00" , buttonTitle: "확인", totalProgress: 0.0 , npcName: "hh",action: {})
        .offset(y:0)
}
