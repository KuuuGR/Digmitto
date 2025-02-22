import SwiftUI

struct TutorialSetpOne: View {
    @StateObject var wordStore = WordStore()
    @State private var currentWord: String = ""
    @State private var navTrigger = false
    @State private var taskCompleted = false
    @State private var didNavigate = false  // Tracks if we have navigated at least once
    
    // Use dismiss to pop the view if needed.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 5) {
            // General Action Text
            Text(LocalizedStringKey("tso_general"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 1)
                .foregroundColor(.purple.opacity(0.7))
                .padding(.bottom, 20)
            
            // Instructions Section
            VStack(alignment: .leading, spacing: 10) {
                Text(LocalizedStringKey(""))
                Text(LocalizedStringKey("tso_how_to_start_title"))
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(LocalizedStringKey("tso_instruction_step1"))
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("tso_instruction_bullet1"))
                    Text(LocalizedStringKey("tso_instruction_bullet2"))
                }
                .font(.callout)
                .foregroundColor(.gray)
                
                Text(LocalizedStringKey("tso_instruction_step2"))
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("tso_instruction_bullet3"))
                    Text(LocalizedStringKey("tso_instruction_bullet4"))
                    Text(LocalizedStringKey("tso_instruction_bullet5"))
                    Text(LocalizedStringKey("tso_instruction_bullet6"))
                    Text(LocalizedStringKey(""))
                }
                .font(.callout)
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            // Conditionally render NavigationLink (for "Start Task") or a plain "Done" button.
            if !taskCompleted {
                NavigationLink(
                    destination: TaskView(
                        currentWord: NSLocalizedString("tso_word_for_practice", comment: ""),
                        isCheatSheetEnabled: false,
                        isRandomizeDiceEnabled: false,
                        wordStore: wordStore,
                        comebackAfterOneWord: true,
                        isBackButtonHidden: true
                    )
                    .environmentObject(wordStore),
                    isActive: $navTrigger
                ) {
                    PastelButton(
                        title: LocalizedStringKey("tso_start_task"),
                        colors: [Color.pink.opacity(0.6), Color.orange.opacity(0.6)]
                        //colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]
                    )
                }
                .padding(.horizontal, 40)
                .simultaneousGesture(
                    TapGesture().onEnded {
                        if currentWord.isEmpty || currentWord == "No word" {
                            currentWord = wordStore.getRandomWord()
                        }
                        print("TutorialSetpOne: currentWord before Navigation = \(currentWord)")
                        didNavigate = true
                        navTrigger = true
                    }
                )
            } else {
                // Once task is completed, show a "Done" button with a new pastel color scheme.
                Button(action: {
                    dismiss()  // Acts like a back button.
                }) {
                    PastelButton(
                        title: LocalizedStringKey("tso_done"),
                        colors: [Color.green.opacity(0.6), Color.yellow.opacity(0.6)]
                        //colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]
                        //colors: [Color.pink.opacity(0.6), Color.orange.opacity(0.6)]
                    )
                }
                .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            print("TutorialSetpOne appeared! Current word: \(currentWord)")
        }
        .onDisappear {
            print("TutorialSetpOne disappeared unexpectedly! Current word: \(currentWord)")
        }
        // When navTrigger goes from true to false and we have navigated, mark task as completed.
        .onChange(of: navTrigger) { newValue in
            if !newValue && didNavigate {
                taskCompleted = true
            }
        }
        // Hide the default navigation bar's back button when task is not complete.
        //.navigationBarBackButtonHidden(!taskCompleted)
        .navigationBarBackButtonHidden(true)
    }
}
