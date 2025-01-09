import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    
    private var wheelColors: [Color] {
        let baseColors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        let wordLength = currentWord.count
        var resultColors: [Color] = []
        
        for i in (0..<wordLength).reversed() {
            let groupIndex = (wordLength - 1 - i) / 3
            let colorIndex = groupIndex % baseColors.count
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
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        Text("Word: \(currentWord)")
                            .font(.title)
                            .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            NumberWheelView(
                                wordLength: max(1, currentWord.count),
                                selectedNumbers: $selectedNumbers,
                                wheelColors: wheelColors
                            )
                            .padding()
                        }
                        
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
                        
                        // Add extra padding at the bottom to ensure space for the button
                        Spacer()
                            .frame(height: 60)
                    }
                }
                
                // CheatSheet button with fixed positioning
                if isCheatSheetEnabled {
                    VStack {
                        Spacer()
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
                            .padding([.trailing, .bottom], 20)
                            // Add shadow to make button stand out
                            .shadow(radius: 3)
                        }
                    }
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