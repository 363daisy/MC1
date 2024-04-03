//
//  EntryView.swift
//  TourBuddy
//
//  Created by NANA on 3/25/24.
//

import SwiftUI

struct EntryView: View {
    @State private var isTextVisible = true
    @State private var userName: String = ""
    var body: some View {
        NavigationStack {
            VStack{
                Image("logoTitle").resizable()
                    .frame(width: 200, height: 65)
                    .padding(.leading, -140)
                    .padding(.top, -50)
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 353, height: 500)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    
                    VStack{
                        Text("좌석을 선택해주세요.")
                            .font(.custom("SangSangShinb7OTF", size: 25))
                            .foregroundColor(Color.black)
                            .bold()
                            .opacity(isTextVisible ? 1 : 0) // 텍스트의 투명도를 조절하여 깜빡거림 효과를 만듭니다.
                            .animation(Animation.easeInOut(duration: 1).repeatForever()) // 깜빡거림 애니메이션을 적용합니다.
                        
                            .onAppear() {
                                self.isTextVisible.toggle() // 텍스트가 보이도록 설정합니다.
                            }
                        Chair(userName: $userName)
                        
                        
                    }
                }
                NavigationLink(destination: CategoryView()) {
                        Text("탑승수속")
                            .font(.custom("SangSangShinb7OTF", size: 20))
                            .foregroundColor(Color.black)
                            .bold()
                            .font(.system(size: 14))
                            .frame(width: 120, height: 20)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#B9E7FF"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2) // border 색상과 두께 설정
                            )
                }.padding(.top,20)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension View{
    func alertTF(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String)->(), secondaryAction: @escaping ()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text{
                primaryAction(text)
            }else{
                primaryAction("")
            }
        }))
        rootController().present(alert, animated: true, completion: nil)
    }
    func rootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}

struct Chair: View {
    @Binding var userName: String
    let numberOfRows = 3
    let numberOfColumns = 4
    let preAssignedSeats: [Int: (String, Bool)] = [3: ("찍찍이", true), 7: ("돌돌이", true), 10: ("짹짹이", true)]
    
    @State private var seatingInfo: [[(String, Bool)]] = Array(repeating: Array(repeating: ("", false), count: 4), count: 3)
    @State private var isMicOn = true
    
    var body: some View {
        VStack {
            ForEach(0..<numberOfRows, id: \.self) { row in
                HStack {
                    ForEach(0..<numberOfColumns, id: \.self) { column in
                        
                        // 변경된 부분: 특정 위치에 사전에 지정된 이름의 의자가 있는 경우
                        if let (name, _) = preAssignedSeats[row * numberOfColumns + column + 1] {
                            VStack {
                                Button(action: {
                                    isMicOn.toggle()
                                }) {
                                    Image(systemName: isMicOn ? "mic.fill" : "mic.slash.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }.padding(.leading, 30)
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.random)
                                Text(name)
                                    .font(.custom("SangSangShinb7OTF", size: 20))
                                    .foregroundColor(Color.black)
                            }
                            .padding(.trailing, 15)
                            .padding(.top, 10)
                            .padding(.bottom,5)
                        } else {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.clear) // 배경은 투명하게
                                .overlay(
                                    Button(action: {
                                        // 변경된 부분: 의자를 클릭했을 때에만 작동하도록 함
                                        if !seatingInfo[row][column].1 {
                                            alertTF(title: "CheckIn", message: "성함을 적어주세요.", hintText: "찍찍이", primaryTitle: "체크인", secondaryTitle: "취소") { text in
                                                // 버튼이 클릭되면 해당 자리의 이미지를 Circle로 변경하고, 텍스트를 저장합니다.
                                                seatingInfo[row][column] = (text, true)
                                                userName = text // 부모 뷰에서 @Binding 변수 변경
                                            } secondaryAction: {
                                                // 취소 액션
                                            }
                                        }
                                    }) {
                                        if seatingInfo[row][column].1 {
                                            VStack {
                                                Button(action: {
                                                    isMicOn.toggle()
                                                }) {
                                                    Image(systemName: isMicOn ? "mic.fill" : "mic.slash.fill")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.black)
                                                }.padding(.leading, 30)
                                                Circle()
                                                    .frame(width: 50, height: 50)
                                                    .foregroundColor(.random)
                                                Text(seatingInfo[row][column].0)
                                                    .font(.custom("SangSangShinb7OTF", size: 20))
                                                    .foregroundColor(Color.black)
                                            }
                                        } else {
                                            Image(systemName: "chair.lounge")
                                                .font(.system(size: 50))
                                                .foregroundColor(.black)
                                        }
                                    }
                                )
                                .padding(.trailing, 15)
                                
                        }
                    }
                }
            }
        }
    }
}







#Preview {
    EntryView()
}
