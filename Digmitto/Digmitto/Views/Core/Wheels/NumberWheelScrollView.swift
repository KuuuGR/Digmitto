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
    let wheelColors: [Color] // Solid or gradient base colors for the wheels

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    Spacer(minLength: shouldCenter(geometry: geometry) ? (geometry.size.width - totalWheelsWidth()) / 2 : 0)
                    ForEach(0..<wordLength, id: \.self) { index in
                        let reverseIndex = (wordLength - 1 - index) / 3
                        NumberWheel(
                            selectedNumber: $selectedNumbers[index],
                            gradient: ColorManager.gradientForGroup(index: reverseIndex) // Apply gradient based on reverse index
                        )
                    }
                    Spacer(minLength: shouldCenter(geometry: geometry) ? (geometry.size.width - totalWheelsWidth()) / 2 : 0)
                }
                .padding(.horizontal, 5)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(Color.gray.opacity(0.1))
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
