//
//  WordDisplayView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//
import SwiftUI

struct WordDisplayView: View {
    @Binding var currentWord: String
    let wordStore: WordStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(currentWord.enumerated()), id: \.offset) { index, char in
                Text(String(char))
                    .foregroundColor(colorForCharacter(char))
                    .font(.largeTitle)
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func colorForCharacter(_ char: Character) -> Color {
        let lowerChar = char.lowercased()
        if wordStore.majorSystemLetters.contains(lowerChar) {
            return wordStore.primaryColor
        } else {
            return wordStore.secondaryColor
        }
    }
}
