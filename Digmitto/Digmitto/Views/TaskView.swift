import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    
    // Updated wheel colors with repeating pattern for words longer than 9 characters
    private var wheelColors: [Color] {
        let baseColors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        let wordLength = currentWord.count
        var resultColors: [Color] = []
        
        // Fill colors from right to left, every three digits get the same color
        for i in (0..<wordLength).reversed() {
            let groupIndex = (wordLength - 1 - i) / 3 // Which group of three (0-based)
            let colorIndex = groupIndex % baseColors.count // Cycle through colors
            resultColors.insert(baseColors[colorIndex], at: 0)
        }
        
        return resultColors
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