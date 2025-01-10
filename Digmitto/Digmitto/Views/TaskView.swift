import SwiftUI

struct TaskView: View {
    var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    @EnvironmentObject var wordStore: WordStore  // Access the WordStore

    private var wheelColors: [Color] {
        let baseColors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        let importantLettersCount = importantLetters.count
        var colors: [Color] = []
        
        // Assign colors from right to left, every three wheels the same color
        for i in stride(from: importantLettersCount - 1, through: 0, by: -1) {
            let colorIndex = (importantLettersCount - 1 - i) / 3 % baseColors.count
            colors.append(baseColors[colorIndex])
        }
        
        return colors.reversed()  // Reverse to match the left-to-right order in the UI
    }
    
    private var importantLetters: [Character] {
        currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }
    }

    init(currentWord: String, isCheatSheetEnabled: Bool, wordStore: WordStore) {
        self.currentWord = currentWord
        self.isCheatSheetEnabled = isCheatSheetEnabled
        let importantLettersCount = currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }.count
        _selectedNumbers = State(initialValue: Array(repeating: 0, count: importantLettersCount))
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
                            HStack {
                                Spacer() // Flexible space before wheels
                                NumberWheelView(
                                    wordLength: selectedNumbers.count, // Use the count of important letters
                                    selectedNumbers: $selectedNumbers,
                                    wheelColors: wheelColors
                                )
                                .padding()
                                Spacer() // Flexible space after wheels
                            }
                            .frame(width: geometry.size.width)
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
                        
                        // Display the word with colorized letters
                        HStack(spacing: 0) {
                            ForEach(Array(currentWord.enumerated()), id: \.offset) { index, char in
                                Text(String(char))
                                    .foregroundColor(colorForCharacter(char))
                            }
                        }
                        .font(.title)
                        .padding(.top, 20)
                        
                        Spacer()
                            .frame(height: 60)
                    }
                }
                
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

    private func colorForCharacter(_ char: Character) -> Color {
        if !wordStore.enableColorization {
            return wordStore.defaultColor
        }
        let lowerChar = char.lowercased()
        if wordStore.majorSystemLetters.contains(lowerChar) {
            return wordStore.primaryColor
        } else {
            return wordStore.secondaryColor
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(currentWord: "example", isCheatSheetEnabled: true, wordStore: WordStore())
            .environmentObject(WordStore())
    }
} 