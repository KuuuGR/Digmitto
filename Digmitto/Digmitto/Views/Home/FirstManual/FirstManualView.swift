import SwiftUI

struct FirstManualView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var navigateToTask: Bool = false
    @State private var disableTutorialNextTime: Bool
    
    init() {
        _disableTutorialNextTime = State(initialValue: UserDefaults.standard.bool(forKey: "hasSeenManual"))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Tutorial Header
            Text("Welcome to the Tutorial!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Tutorial Content
            Text("Here we explain how to use the app. Follow along!")
                .padding()

            Spacer()

            // Start Task Button
            Button(action: {
                navigateToTask = true
            }) {
                Text("Start Learning")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Toggle (User decides if tutorial should appear next time)
            Toggle("Don't show tutorial next time", isOn: $disableTutorialNextTime)
                .padding()

            // Hidden navigation to TaskView
            NavigationLink(
                destination: TaskView(
                    currentWord: wordStore.getRandomWord(),
                    isCheatSheetEnabled: wordStore.isCheatSheetEnabled,
                    isRandomizeDiceEnabled: wordStore.isRandomizeDiceEnabled,
                    wordStore: wordStore
                )
                .onAppear {
                    print("TaskView appeared!")
                }
                .onDisappear {
                    print("TaskView disappeared! Returning to FirstManualView")
                    
                    // Save the setting **only after TaskView is closed**
                    DispatchQueue.main.async {
                        saveManualPreference()
                        navigateToTask = false
                    }
                }
                .navigationBarBackButtonHidden(true),
                isActive: $navigateToTask
            ) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
        .onAppear {
            print("FirstManualView Appeared - hasSeenManual: \(wordStore.hasSeenManual)")
        }
        .onDisappear {
            print("FirstManualView Disappeared! Checking if we should save preference...")
            saveManualPreference()
        }
    }
    
    /// Saves `hasSeenManual` preference when user leaves tutorial
    private func saveManualPreference() {
        if disableTutorialNextTime {
            print("Saving hasSeenManual: true")
            wordStore.hasSeenManual = true
            UserDefaults.standard.set(true, forKey: "hasSeenManual")
        }
    }
}
