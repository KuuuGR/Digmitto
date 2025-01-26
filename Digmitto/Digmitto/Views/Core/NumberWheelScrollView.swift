//
//  NumberWheelScrollView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct NumberWheelScrollView: View {
    let wordLength: Int
    @Binding var selectedNumbers: [Int]
    let wheelColors: [Color]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) { // Adjust spacing for better appearance
                Spacer() // Adds space on the left
                NumberWheelView(
                    wordLength: wordLength,
                    selectedNumbers: $selectedNumbers,
                    wheelColors: wheelColors
                )
                Spacer() // Adds space on the right
            }
            .frame(maxWidth: .infinity) // Ensures the entire HStack takes available space
            .frame(height: 100) // Adjust height if needed
        }
        .frame(maxWidth: .infinity) // Ensures the scroll view takes available space
    }
}
