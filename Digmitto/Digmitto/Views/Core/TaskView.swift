import SwiftUI

struct TaskView: View {
    @State private var currentWord: String
    var isCheatSheetEnabled: Bool
    var isRandomizeDiceEnabled: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var isCheatSheetVisible = false
    @State private var points = 0
    @State private var fruitEmojis: [String] = []
    @State private var attempts = 0
    @State private var buttonGradientIndex: Int = 0 // Tracks the current gradient index
    @State private var buttonColors: [Color] = [Color.red.opacity(0.6), Color.orange.opacity(0.6)] // Initial gradient colors
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

    init(currentWord: String, isCheatSheetEnabled: Bool, isRandomizeDiceEnabled: Bool, wordStore: WordStore) {
        self.isCheatSheetEnabled = isCheatSheetEnabled
        self.isRandomizeDiceEnabled = isRandomizeDiceEnabled
        if currentWord.isEmpty || currentWord == "No word" {
            self._currentWord = State(initialValue: wordStore.getRandomWord())
        } else {
            self._currentWord = State(initialValue: currentWord)
        }
        let importantLettersCount = self._currentWord.wrappedValue.filter { wordStore.majorSystemLetters.contains($0.lowercased()) }.count
        self._selectedNumbers = State(initialValue: Array(repeating: 0, count: importantLettersCount))
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
                                withAnimation {
                                    loadNewWord()
                                }
                                // Update Button Gradient Index and Colors
                                withAnimation {
                                    buttonGradientIndex = (buttonGradientIndex + 1) % densePastelGradients.count
                                    buttonColors = densePastelGradients[buttonGradientIndex]
                                }
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
                                .frame(maxWidth: 200, minHeight: 50) // Fixed width and height
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
                        
                        // Feedback Section
                        Text(feedback)
                            .padding()
                        
                        Spacer()
                            .frame(height: isCheatSheetEnabled ? 60 : 10)
                    }
                    
                    //  Side Labels -> points and fruits
                    if !isCheatSheetEnabled {
                        VStack {
                            Spacer()
                            HStack(alignment: .top, spacing: 10) {
                                // Fruits and Points Labels
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(String(format: NSLocalizedString("tv_points", comment: ""), points))
                                        .font(.title2)
                                        .padding(.bottom, 4)
                                    Text(String(format: NSLocalizedString("tv_fruits", comment: ""), fruitEmojis.joined(separator: " ")))
                                        .font(.title2)
                                }
                                .frame(width: geometry.size.width * 0.9, alignment: .leading)
                                .padding(.leading, 20)
                            }
                        }
                    }
                    
                    // Cheat Sheet View and Side Labels
                    if isCheatSheetEnabled {
                        VStack {
                            Spacer()
                            HStack(alignment: .top, spacing: 10) {
                                // Fruits and Points Labels
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(String(format: NSLocalizedString("tv_points", comment: ""), points))
                                        .font(.title2)
                                        .padding(.bottom, 4)
                                    Text(String(format: NSLocalizedString("tv_fruits", comment: ""), fruitEmojis.joined(separator: " ")))
                                        .font(.title2)
                                }
                                .frame(width: geometry.size.width * 0.6, alignment: .leading)
                                .padding(.leading, 20)
                                
                                // Cheat Sheet View
                                CheatSheetView()
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.2) // Now takes 20% of the screen height
                                    .background(
                                        Image("parchmentBackground")
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .cornerRadius(20)
                                    .shadow(color: .gray.opacity(0.6), radius: 10, x: -5, y: 5)
                                    .padding([.trailing, .bottom], 20)
                            }
                        }
                    }
                    
                    if isRandomizeDiceEnabled {
                        // Dice Button to Generate Random Word
                        Spacer() // Pushes the button to the bottom
                        
                        Button(action: {
                            withAnimation {
                                loadNewWord()
                            }
                        }) {
                            Image(systemName: "die.face.6.fill")
                                .resizable()
                                .scaledToFit() // Ensures the image scales proportionally
                                .frame(width: 40, height: 40) // Adjust this size to fit the button dimensions
                                .padding(10) // Slight padding for a better look
                                .background(Color.yellow.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(10) // Matches the button's corner radius
                                .shadow(radius: 5)
                        }
                        .frame(width: 60, height: 60) // The button's overall size
                        .padding(.bottom, 5)
                        .opacity(0.8)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                DispatchQueue.main.async {
                    startSession()
                }
            }
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
