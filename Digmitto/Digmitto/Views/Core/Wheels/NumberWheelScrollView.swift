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
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    Spacer(minLength: shouldCenter(geometry: geometry) ? (geometry.size.width - totalWheelsWidth()) / 2 : 0) // Center if necessary
                    ForEach(0..<wordLength, id: \.self) { index in
                        NumberWheel(
                            selectedNumber: $selectedNumbers[index],
                            color: wheelColors[index % wheelColors.count]
                        )
                    }
                    Spacer(minLength: shouldCenter(geometry: geometry) ? (geometry.size.width - totalWheelsWidth()) / 2 : 0) // Center if necessary
                }
                .padding(.horizontal, 5)
            }
            .frame(maxWidth: .infinity) // Ensures the scroll view takes up the available width
            .frame(height: 150) // Adjust height as needed
            .background(Color.gray.opacity(0.1)) // Optional background
        }
    }

    private func shouldCenter(geometry: GeometryProxy) -> Bool {
        return totalWheelsWidth() < geometry.size.width
    }

    private func totalWheelsWidth() -> CGFloat {
        let wheelWidth: CGFloat = 60 // Same width as defined in `NumberWheel`
        let spacing: CGFloat = 4    // Spacing between wheels
        return CGFloat(wordLength) * wheelWidth + CGFloat(wordLength - 1) * spacing
    }
}
