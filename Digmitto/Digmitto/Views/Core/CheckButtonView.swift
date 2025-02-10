//
//  CheckButtonView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct CheckButtonView: View {
    @Binding var buttonGradientIndex: Int
    @Binding var buttonColors: [Color]
    @Binding var feedback: String
    @Binding var attempts: Int
    @Binding var points: Int
    @Binding var fruitEmojis: [String]
    @Binding var selectedNumbers: [Int]
    @Binding var currentWord: String
    let wordStore: WordStore
    let loadNewWord: () -> Void

    var body: some View {
        Button(action: handleCheck) {
            Text(LocalizedStringKey("tv_check_button"))
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: 250, minHeight: 65)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: buttonColors),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
        .onAppear {
            animateGradient()
        }
    }

    private func handleCheck() {
        let letterString = convertLettersToNumbers()
        let wheelString = readWheelsRightToLeft()

        if letterString == wheelString {
            feedback = NSLocalizedString("tv_feedback_correct", comment: "")
            wordStore.totalPoints += 1
            if attempts == 0 {
                points += 1
                addRandomFruitEmoji()
            }

            // Change button color and load a new word
            withAnimation {
                buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
                buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
            }
            loadNewWord()
        } else {
            feedback = String(
                format: NSLocalizedString("tv_feedback_incorrect", comment: ""),
                letterString,
                wheelString
            )
            attempts += 1
        }
    }

    private func convertLettersToNumbers() -> String {
        currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }
            .map { wordStore.numberForLetter(String($0.lowercased())) }
            .joined()
    }

    private func readWheelsRightToLeft() -> String {
        selectedNumbers.map(String.init).joined()
    }

    private func addRandomFruitEmoji() {
        let fruits = ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"]
        if let randomFruit = fruits.randomElement() {
            fruitEmojis.append(randomFruit)
        }
    }

    private func animateGradient() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
            buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
            buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
        }
    }
}
