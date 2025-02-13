import SwiftUI

struct TaskView: View {
    // Local state variables
    @State private var currentWord: String
    var isCheatSheetEnabled: Bool
    var isRandomizeDiceEnabled: Bool
    var comebackAfterOneWord: Bool
    /// New property to control back button visibility
    let isBackButtonHidden: Bool
    @State private var selectedNumbers: [Int]
    @State private var feedback = ""
    @State private var points = 0
    @State private var fruitEmojis: [String] = []
    @State private var attempts = 0
    @State private var buttonGradientIndex: Int = 0
    @State private var buttonColors: [Color] = ColorManager.buttonGradient(for: 0)
    @State private var firstPressDone: Bool = false

    @EnvironmentObject var wordStore: WordStore
    @Environment(\.dismiss) private var dismiss  // For dismissing the view

    // Modified initializer now stores the back button visibility flag.
    init(currentWord: String,
         isCheatSheetEnabled: Bool,
         isRandomizeDiceEnabled: Bool,
         wordStore: WordStore,
         comebackAfterOneWord: Bool = false,
         isBackButtonHidden: Bool = false) {
        
        self.isCheatSheetEnabled = isCheatSheetEnabled
        self.isRandomizeDiceEnabled = isRandomizeDiceEnabled
        self.comebackAfterOneWord = comebackAfterOneWord
        // Assign the parameter to the property (note the corrected spelling)
        self.isBackButtonHidden = isBackButtonHidden
        
        if currentWord.isEmpty || currentWord == "No word" {
            self._currentWord = State(initialValue: wordStore.getRandomWord())
        } else {
            self._currentWord = State(initialValue: currentWord)
        }
        let importantLettersCount = self._currentWord.wrappedValue.filter {
            wordStore.majorSystemLetters.contains($0.lowercased())
        }.count
        self._selectedNumbers = State(initialValue: Array(repeating: 0, count: importantLettersCount))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) { // Main static container
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
                                    dismiss() // Second press immediately dismisses the view
                                } else {
                                    firstPressDone = true // Mark first press
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
                    updateButtonColors() // Ensure initial colors are set
                }
            }
        }
        // Hide or show the navigation bar's back button based on backButtonVisible.
        .navigationBarBackButtonHidden(isBackButtonHidden)
    }

    // MARK: - Helper Functions

    /// Resets session-related variables and logs the session start time.
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

    /// Cycles through the available button gradients.
    private func updateButtonColors() {
        buttonGradientIndex = (buttonGradientIndex + 1) % ColorManager.buttonGradients.count
        buttonColors = ColorManager.buttonGradient(for: buttonGradientIndex)
    }

    /// Loads a new word from WordStore and resets the attempts counter.
    private func loadWord(newOne: Bool = true) {
        if newOne {
            currentWord = wordStore.getRandomWord()
        }
        let importantLettersCount = currentWord.filter {
            wordStore.majorSystemLetters.contains($0.lowercased())
        }.count
        selectedNumbers = Array(repeating: 0, count: importantLettersCount)
        attempts = 0
    }
}
