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
                        Button(action: {
                            let letterString = convertLettersToNumbers()
                            let wheelString = readWheelsRightToLeft()
                            
                            if letterString == wheelString {
                                feedback = NSLocalizedString("tv_feedback_correct", comment: "")
                                wordStore.totalPoints += 1
                                if attempts == 0 {
                                    points += 1
                                    addRandomFruitEmoji()
                                }
                                completeTask(isCorrect: true)
                                loadNewWord()
                            } else {
                                feedback = String(
                                    format: NSLocalizedString("tv_feedback_incorrect", comment: ""),
                                    letterString,
                                    wheelString
                                )
                                attempts += 1
                                completeTask(isCorrect: false)
                            }
                        }) {
                            Text(LocalizedStringKey("tv_check_button"))
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()

                        // Feedback Section
                        Text(feedback)
                            .padding()

                        Spacer()
                            .frame(height: isCheatSheetEnabled ? 60 : 10)
                    }
                    
                    // Fruits and Points Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text(String(format: NSLocalizedString("tv_points", comment: ""), points))
                            .font(.title2)
                        Text(String(format: NSLocalizedString("tv_fruits", comment: ""), fruitEmojis.joined(separator: " ")))
                            .font(.title2)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startSession()
        }
    }

    private func startSession() {
        points = 0
        fruitEmojis = []
        attempts = 0
        wordStore.tasksCompletedInSession = 0
        wordStore.currentSessionMistakes = 0
        wordStore.sessionStartTime = Date()
        wordStore.fruitsCollectedInSession.removeAll()
        print("Session started at \(wordStore.sessionStartTime!)")
    }

    private func completeTask(isCorrect: Bool) {
        if isCorrect {
            wordStore.tasksCompletedInSession += 1
        } else {
            wordStore.currentSessionMistakes += 1
        }
        print("Task completed. Tasks: \(wordStore.tasksCompletedInSession), Mistakes: \(wordStore.currentSessionMistakes)")
        wordStore.checkAchievements()
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
        if let randomFruit = fruits.randomElement() {
            fruitEmojis.append(randomFruit)
            wordStore.collectFruit(randomFruit)
        }
    }
}
