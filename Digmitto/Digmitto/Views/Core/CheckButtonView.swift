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
    var specialTextOnSuccess: String? = nil // Optional custom success text for the button

    @State private var buttonText: LocalizedStringKey = "tv_check_button" // Default button text

    var body: some View {
        Button(action: handleCheck) {
            Text(buttonText) // Button label that can change dynamically
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
            // Correct answer: update feedback.
            feedback = NSLocalizedString("tv_feedback_correct", comment: "")
            
            // Increment the session task counter first.
            wordStore.tasksCompletedInSession += 1
            print("Task completed. tasksCompletedInSession: \(wordStore.tasksCompletedInSession)")
            
            // Now increment the overall points.
            wordStore.totalPoints += 1
            
            // If this is the first attempt, update local points and award a fruit.
            if attempts == 0 {
                points += 1
                addRandomFruitEmoji()
            }
            
            // Immediately check achievements.
            wordStore.checkAchievements()
            
            // Animate button color change.
            withAnimation {
                buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
                buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
            }
            
            // Change button text if specialTextOnSuccess is provided.
            if let newText = specialTextOnSuccess {
                buttonText = LocalizedStringKey(newText)
            }
            
            // Load the next word.
            loadNewWord()
        } else {
            // Incorrect answer: update feedback and increment attempts.
            feedback = String(
                format: NSLocalizedString("tv_feedback_incorrect", comment: ""),
                letterString,
                wheelString
            )
            // Optionally, increment mistake counter if desired:
            // wordStore.currentSessionMistakes += 1
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
            wordStore.collectFruit(randomFruit)
        }
    }
    
    private func animateGradient() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
            buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
            buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
        }
    }
}
