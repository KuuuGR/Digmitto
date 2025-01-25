//
//  ColorExtension.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 24/01/2025.
//
import SwiftUI

extension Color {
    static let softBlue = Color(hex: "#9cadce")
    static let paleLavender = Color(hex: "#d1cfe2")
    static let pastelPurple = Color(hex: "#e8dff5")
    static let softMauve = Color(hex: "#d4afb9")
    static let pastelPink = Color(hex: "#fce1e4")
    static let pastelYellow = Color(hex: "#fcf4dd")
    static let pastelGreen = Color(hex: "#ddedea")
    static let skyBlue = Color(hex: "#7ec4cf")
    static let pastelBlue = Color(hex: "#daeaf6")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
