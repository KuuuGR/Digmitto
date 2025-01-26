//
//  ColorManager.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct ColorManager {
    // Default colors for gradients
    static let defaultGradients: [[Color]] = [
        [Color.red.opacity(0.6), Color.orange.opacity(0.6)],
        [Color.green.opacity(0.6), Color.blue.opacity(0.6)],
        [Color.purple.opacity(0.6), Color.pink.opacity(0.6)],
        [Color.yellow.opacity(0.6), Color.lightGreen.opacity(0.6)]
    ]
    
    static let baseColors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]

    /// Returns a gradient for a given group index
    static func gradientForGroup(index: Int) -> LinearGradient {
        let colors = defaultGradients[index % defaultGradients.count]
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    /// Returns a color for a specific index (solid color fallback)
    static func colorForIndex(index: Int) -> Color {
        let allColors: [Color] = [
            .red, .orange, .yellow, .green, .blue, .purple, .pink
        ]
        return allColors[index % allColors.count]
    }
    
    /// Generates an array of colors for the wheels, ensuring they are grouped and cycled.
    static func generateWheelColors(for count: Int) -> [Color] {
        var colors: [Color] = []
        for i in 0..<count {
            let colorIndex = i / 3 % baseColors.count // Grouped into sets of 3
            colors.append(baseColors[colorIndex])
        }
        return colors
    }
}

extension ColorManager {
    
    static var systemBackground: Color {
        Color(UIColor.systemBackground)
    }
    
    static func buttonGradient(forIndex index: Int) -> LinearGradient {
        gradientForGroup(index: index)
    }
    
    static let buttonGradients: [[Color]] = [
        [Color.red.opacity(0.6), Color.orange.opacity(0.6)],
        [Color.green.opacity(0.6), Color.blue.opacity(0.6)],
        [Color.purple.opacity(0.6), Color.pink.opacity(0.6)]
    ]
    
    /// Returns a gradient for the button based on the given index.
    static func buttonGradient(for index: Int) -> [Color] {
        buttonGradients[index % buttonGradients.count]
    }
    
}
