import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var userInput = ""
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false

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
            
            if isCheatSheetEnabled {
                Button(action: {
                    isCheatSheetVisible.toggle()
                }) {
                    Text("Show Cheat Sheet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .sheet(isPresented: $isCheatSheetVisible) {
            CheatSheetView()
        }
    }

    func validateInput(_ input: String) -> Bool {
        // Implement validation logic
        return true
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(currentWord: "example", isCheatSheetEnabled: true)
    }
} 