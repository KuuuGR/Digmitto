import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var userInput = ""
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false

    var body: some View {
        ZStack {
            VStack {
                // Main content
                Text("Word: \(currentWord)")
                    .font(.title)
                    .padding(.top, 20)
                
                TextField("Enter number", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Code") {
                    if validateInput(userInput) {
                        feedback = "Correct! 🌟"
                    } else {
                        feedback = "Try again! ❌"
                    }
                }
                
                Text(feedback)
                    .padding()
                
                Spacer()
            }
            
            // Cheat Sheet Button in top-right corner
            if isCheatSheetEnabled {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isCheatSheetVisible.toggle()
                        }) {
                            Text("📝")
                                .font(.system(size: 24))
                                .padding(8)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }
            }
        }
        .popover(isPresented: $isCheatSheetVisible) {
            CheatSheetView()
                .frame(width: 200, height: 300) // Control the size of the popover
        }
        .navigationBarTitleDisplayMode(.inline)
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