//
//  Color+.swift
//  TourBuddy
//
//  Created by NANA on 3/24/24.
//

import SwiftUI
 
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
 
    static let mainColor = Color(hex: "#B9E7FF")
    static let graphRed = Color(hex: "E45244")
    static let gameYellow = Color(hex: "F1E78C")  // #을 제거하고 사용해도 됩니다.
    static var random: Color {
                return Color(red: .random(in: 0...1),
                             green: .random(in: 0...1),
                             blue: .random(in: 0...1))
            }
}
