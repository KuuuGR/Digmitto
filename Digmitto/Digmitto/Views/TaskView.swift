import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    
    // Add wheel colors
    private var wheelColors: [Color] {
        // You can customize this array based on your needs
        let colors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        return Array(colors.prefix(currentWord.count))
    }
    
    init(currentWord: String, isCheatSheetEnabled: Bool) {
        self.currentWord = currentWord
        self.isCheatSheetEnabled = isCheatSheetEnabled
        let length = max(1, currentWord.count)
        _selectedNumbers = State(initialValue: Array(repeating: 0, count: length))
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Word: \(currentWord)")
                    .font(.title)
                    .padding(.top, 20)
                
                NumberWheelView(
                    wordLength: max(1, currentWord.count),
                    selectedNumbers: $selectedNumbers,
                    wheelColors: wheelColors
                )
                .padding()
                
                Button("Check") {
                    if validateInput(selectedNumbers) {
                        feedback = "Correct! 🌟"
                    } else {
                        feedback = "Try again! ❌"
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                Text(feedback)
                    .padding()
                
                Spacer()
            }
            
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
                .frame(width: 200, height: 300)
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    func validateInput(_ numbers: [Int]) -> Bool {
        // Implement validation logic for the array of numbers
        return true
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(currentWord: "example", isCheatSheetEnabled: true)
    }
} 