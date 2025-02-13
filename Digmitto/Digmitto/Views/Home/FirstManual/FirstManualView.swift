import SwiftUI

struct FirstManualView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var navigateToTask: Bool = false
    @State private var disableTutorialNextTime: Bool
    
    init() {
        _disableTutorialNextTime = State(initialValue: UserDefaults.standard.bool(forKey: "hasSeenManual"))
    }

    @State private var step1Completed: Bool = false
    @State private var step2Completed: Bool = false
    @State private var step3Completed: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Tutorial Header
            Text(LocalizedStringKey("fm_welcome"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Tutorial Content
            Text(LocalizedStringKey("fm_tutorial_steps"))
                .padding()

            // Step Buttons (Stacked Vertically)
            VStack(spacing: 15) {
                StepButton(
                    number: "1",
                    isCompleted: step1Completed,
                    isNextStep: step1Completed,
                    isEnabled: true, // Step 1 is always available
                    defaultGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    nextStepGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    activeGradient: LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    destination: AnyView(TutorialSetpOne().onDisappear { step1Completed = true }) // Unlocks Step 2
                )
                StepButton(
                    number: "2",
                    isCompleted: step2Completed,
                    isNextStep: step1Completed,
                    isEnabled: step1Completed, // Step 2 unlocks after Step 1
                    defaultGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    nextStepGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    activeGradient: LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.yellow.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    destination: AnyView(TutorialStepTwo().onDisappear { step2Completed = true }) // Unlocks Step 3
                )
                StepButton(
                    number: "3",
                    isCompleted: step3Completed,
                    isNextStep: step2Completed,
                    isEnabled: step2Completed, // Step 3 unlocks after Step 2
                    defaultGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    nextStepGradient: LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    activeGradient: LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    destination: AnyView(TutorialStepThree().onDisappear { step3Completed = true }) // Final step
                )
            }
            
            // Start Button
            NavigationLink(destination: StartView()) {
                PastelButton(
                    title: LocalizedStringKey("fm_start"),
                    colors: [Color.lightGreen.opacity(0.6), Color.pastelGreen.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            .disabled(!step3Completed)
            .opacity(step3Completed ? 0.8 : 0.1)

            // Toggle (User decides if tutorial should appear next time)
            Toggle(LocalizedStringKey("fm_dont_show_next_time"), isOn: $disableTutorialNextTime)
                .padding()
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

struct StepButton: View {
    let number: String
    let isCompleted: Bool
    let isNextStep: Bool
    let isEnabled: Bool
    let defaultGradient: LinearGradient
    let nextStepGradient: LinearGradient
    let activeGradient: LinearGradient
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            Text(number)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(
                    isCompleted ? AnyView(activeGradient) : // Fully colored if completed
                    isNextStep ? AnyView(nextStepGradient) :  // Light gray if it's the next step
                    AnyView(defaultGradient)                 // Dark gray if locked
                )
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .disabled(!isEnabled) // Prevent clicking out of order
    }
}
