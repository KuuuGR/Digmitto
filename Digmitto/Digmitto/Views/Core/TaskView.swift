import SwiftUI

struct TaskView: View {
    // Local state variables
    @State private var currentWord: String = "" // Initially empty, will be set onAppear
    var isCheatSheetEnabled: Bool
    var isRandomizeDiceEnabled: Bool
    var comebackAfterOneWord: Bool
    let isBackButtonHidden: Bool
    @State private var selectedNumbers: [Int] = []
    @State private var feedback = ""
    @State private var points = 0
    @State private var fruitEmojis: [String] = []
    @State private var attempts = 0
    @State private var buttonGradientIndex: Int = 0
    @State private var buttonColors: [Color] = ColorManager.buttonGradient(for: 0)
    @State private var firstPressDone: Bool = false

    @EnvironmentObject var wordStore: WordStore
    @Environment(\.dismiss) private var dismiss  // For dismissing the view

    /// Flag indicating if a non-empty word was provided during initialization.
    private let wordWasProvided: Bool

    /// New flag: if true, force a new random word every time the view appears.
    private let forceRandomOnReappear: Bool

    /// Modified initializer.
    /// - Parameters:
    ///   - currentWord: Optional word to use. If nil or empty (or equals "No word"), a random word is used.
    ///   - isCheatSheetEnabled: Whether the cheat sheet is enabled.
    ///   - isRandomizeDiceEnabled: Whether the dice button is enabled.
    ///   - wordStore: The shared WordStore.
    ///   - comebackAfterOneWord: Special behavior flag.
    ///   - isBackButtonHidden: Controls the visibility of the navigation bar's back button.
    ///   - forceRandomOnReappear: If true, always generate a new random word on each appearance.
    init(currentWord: String? = nil,
         isCheatSheetEnabled: Bool,
         isRandomizeDiceEnabled: Bool,
         wordStore: WordStore,
         comebackAfterOneWord: Bool = false,
         isBackButtonHidden: Bool = false,
         forceRandomOnReappear: Bool = false) {
        
        self.isCheatSheetEnabled = isCheatSheetEnabled
        self.isRandomizeDiceEnabled = isRandomizeDiceEnabled
        self.comebackAfterOneWord = comebackAfterOneWord
        self.isBackButtonHidden = isBackButtonHidden
        self.forceRandomOnReappear = forceRandomOnReappear
        
        // Treat nil, empty, or "No word" as not provided.
        if let providedWord = currentWord,
           !providedWord.trimmingCharacters(in: .whitespaces).isEmpty,
           providedWord != "No word" {
            self._currentWord = State(initialValue: providedWord)
            self.wordWasProvided = true
        } else {
            self.wordWasProvided = false
            // Leave currentWord as empty; it will be updated onAppear.
        }
        
        let importantLettersCount = self._currentWord.wrappedValue.filter {
            wordStore.majorSystemLetters.contains($0.lowercased())
        }.count
        self._selectedNumbers = State(initialValue: Array(repeating: 0, count: importantLettersCount))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                // Word Display
                WordDisplayView(currentWord: $currentWord, wordStore: wordStore)

                // Number Wheel View
                NumberWheelScrollView(
                    wordLength: selectedNumbers.count,
                    selectedNumbers: $selectedNumbers,
                    wheelColors: ColorManager.generateWheelColors(for: selectedNumbers.count)
                )
                .frame(height: 150) // Fixed height for the wheel area

                // Check Button
                CheckButtonView(
                    buttonGradientIndex: $buttonGradientIndex,
                    buttonColors: $buttonColors,
                    feedback: $feedback,
                    attempts: $attempts,
                    points: $points,
                    fruitEmojis: $fruitEmojis,
                    selectedNumbers: $selectedNumbers,
                    currentWord: $currentWord,
                    wordStore: wordStore,
                    loadNewWord: {
                        withAnimation {
                            if comebackAfterOneWord {
                                if firstPressDone {
                                    dismiss()
                                } else {
                                    firstPressDone = true
                                    feedback = NSLocalizedString("tv_feedback_correct_special", comment: "")
                                }
                            } else {
                                loadWord()
                            }
                            updateButtonColors()
                        }
                    },
                    specialTextOnSuccess: comebackAfterOneWord ?
                        NSLocalizedString("tv_feedback_correct_special_button_text", comment: "") : nil
                )

                // Feedback Section
                FeedbackView(feedback: feedback)

                // Cheat Sheet or Side Labels
                if isCheatSheetEnabled {
                    CheatSheetAndLabelsView(points: points, fruitEmojis: fruitEmojis, geometry: geometry)
                } else {
                    PointsAndFruitsView(points: points, fruitEmojis: fruitEmojis)
                }

                // Dice Button
                if isRandomizeDiceEnabled {
                    DiceButtonView {
                        loadWord()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorManager.systemBackground)
            .onAppear {
                DispatchQueue.main.async {
                    startSession()
                    updateButtonColors()
                    
                    // Generate a new random word if forceRandomOnReappear is true or no valid word was provided.
                    if forceRandomOnReappear || !wordWasProvided {
                        currentWord = wordStore.getRandomWord()
                        print("✅ New random word on re-entry: \(currentWord)")
                    } else {
                        print("✅ Using provided word: \(currentWord)")
                    }
                    
                    updateSelectedNumbers()
                }
            }
        }
        .navigationBarBackButtonHidden(isBackButtonHidden)
    }

    // MARK: - Helper Functions

    private func startSession() {
        points = 0
        fruitEmojis = []
        attempts = 0
        wordStore.tasksCompletedInSession = 0
        wordStore.currentSessionMistakes = 0
        wordStore.sessionStartTime = Date()
        wordStore.fruitsCollectedInSession.removeAll()
        print("Session started at \(wordStore.sessionStartTime!)")
        print("tasksCompletedInSession reset to \(wordStore.tasksCompletedInSession)")
        print("currentSessionMistakes reset to \(wordStore.currentSessionMistakes)")
    }

    private func updateButtonColors() {
        buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
        buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
    }

    private func loadWord(newOne: Bool = true) {
        if newOne {
            currentWord = wordStore.getRandomWord()
            print("✅ Loaded new word: \(currentWord)")
        }
        updateSelectedNumbers()
        attempts = 0
    }

    private func updateSelectedNumbers() {
        let importantLettersCount = currentWord.filter {
            wordStore.majorSystemLetters.contains($0.lowercased())
        }.count
        selectedNumbers = Array(repeating: 0, count: importantLettersCount)
    }
}
