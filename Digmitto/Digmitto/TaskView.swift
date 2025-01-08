import SwiftUI

struct TaskView: View {
    var currentWord: String
    @State private var userInput = ""
    @State private var feedback = ""

    var body: some View {
        VStack {
            Button("Back") {
                // Navigate back
            }
            Text("Word: \(currentWord)")
                .font(.title)
            TextField("Enter number", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Code") {
                // Validate input
                if validateInput(userInput) {
                    feedback = "Correct! 🌟"
                } else {
                    feedback = "Try again! ❌"
                }
            }
            Text(feedback)
                .padding()
        }
    }

    func validateInput(_ input: String) -> Bool {
        // Implement validation logic
        return true
    }
} 