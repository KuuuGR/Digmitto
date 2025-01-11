import SwiftUI

struct TaskView: View {
    @State private var currentWord: String
    var isCheatSheetEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    @State private var points = 0
    @State private var fruitEmojis: [String] = []
    @State private var attempts = 0
    @EnvironmentObject var wordStore: WordStore

    private var wheelColors: [Color] {
        let baseColors: [Color] = [.blue, .red, .green, .orange, .purple, .pink]
        let importantLettersCount = importantLetters.count
        var colors: [Color] = []
        
        for i in stride(from: importantLettersCount - 1, through: 0, by: -1) {
            let colorIndex = (importantLettersCount - 1 - i) / 3 % baseColors.count
            colors.append(baseColors[colorIndex])
        }
        
        return colors.reversed()
    }
    
    private var importantLetters: [Character] {
        currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }
    }

    init(currentWord: String, isCheatSheetEnabled: Bool, wordStore: WordStore) {
        self.isCheatSheetEnabled = isCheatSheetEnabled
        let importantLettersCount = currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }.count
        _currentWord = State(initialValue: currentWord)
        _selectedNumbers = State(initialValue: Array(repeating: 0, count: importantLettersCount))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        // Current Word Display
                        HStack(spacing: 0) {
                            ForEach(Array(currentWord.enumerated()), id: \.offset) { index, char in
                                Text(String(char))
                                    .foregroundColor(colorForCharacter(char))
                                    .font(.largeTitle)
                            }
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .center)

                        // Number Wheel View
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer()
                                NumberWheelView(
                                    wordLength: selectedNumbers.count,
                                    selectedNumbers: $selectedNumbers,
                                    wheelColors: wheelColors
                                )
                                .padding()
                                Spacer()
                            }
                            .frame(width: geometry.size.width)
                        }
                        
                        // Check Button
                        Button("Check") {
                            let letterString = convertLettersToNumbers()
                            let wheelString = readWheelsRightToLeft()
                            
                            if letterString == wheelString {
                                feedback = "Correct! 🌟"
                                if attempts == 0 {
                                    points += 1
                                    addRandomFruitEmoji()
                                }
                                loadNewWord()
                            } else {
                                feedback =
                                """
                                Try again! ❌ 
                                
                                Letters: \(letterString), 
                                Wheels: \(wheelString)
                                """
                                attempts += 1
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                        // Feedback Section
                        Text(feedback)
                            .padding()

                        // Points Section
                        HStack {
                            Text("Points: \(points)")
                                .font(.title2)
                                .padding()
                            Spacer()
                        }

                        // Fruits Emoji Section
                        HStack {
                            Text("Fruits: \(fruitEmojis.joined(separator: " "))")
                                .font(.title2)
                                .padding()
                            Spacer()
                        }

                        Spacer()
                            .frame(height: 60)
                    }
                }
                
                // Cheat Sheet Toggle
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

    private func convertLettersToNumbers() -> String {
        importantLetters.map { char in
            wordStore.numberForLetter(String(char.lowercased()))
        }.joined()
    }

    private func readWheelsRightToLeft() -> String {
        selectedNumbers.map(String.init).joined()
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
    
    private func loadNewWord() {
        currentWord = wordStore.getRandomWord()
        let importantLettersCount = currentWord.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }.count
        selectedNumbers = Array(repeating: 0, count: importantLettersCount)
        attempts = 0
    }
    
    private func addRandomFruitEmoji() {
        let fruits = ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"]
        //fruitsPlusVegetables = ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅", "🥒", "🥕", "🌽", "🥔", "🍆", "🥑", "🥬", "🥦", "🧄", "🧅", "🌶️", "🫛", "🫘", "🥗"]
        if let randomFruit = fruits.randomElement() {
            fruitEmojis.append(randomFruit)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(currentWord: "example", isCheatSheetEnabled: true, wordStore: WordStore())
            .environmentObject(WordStore())
    }
}
