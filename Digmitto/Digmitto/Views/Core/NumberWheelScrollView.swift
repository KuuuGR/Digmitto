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
                ForEach(0..<wordLength, id: \.self) { index in
                    NumberWheel(
                        selectedNumber: $selectedNumbers[index],
                        color: wheelColors[index % wheelColors.count]
                    )
                }
            }
            .frame(maxWidth: .infinity) // Ensure the HStack takes available space
        }
        .frame(maxWidth: .infinity) // Ensure the ScrollView takes available space
        .frame(height: 150) // Adjust height for the wheels
        .background(Color.gray.opacity(0.1)) // Optional: Add a subtle background
        .padding(.horizontal, 20) // Optional: Add horizontal padding
    }
}
