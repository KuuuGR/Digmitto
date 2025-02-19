import SwiftUI
import Combine

struct StartView: View {
    @StateObject var wordStore = WordStore()
    @State private var currentWord: String = ""
    @State private var navTrigger = false
    @State private var localAchievements: [Bool] = Array(repeating: false, count: 9)
    
    // A subscription for updates from WordStore
    @State private var achievementsCancellable: AnyCancellable?

    var body: some View {
        VStack(spacing: 5) {
            // General Action Text
            Text(LocalizedStringKey("st_general"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 1)
                .foregroundColor(.purple.opacity(0.7))
                .padding(.bottom, 20)
            
            // Instructions Section
            VStack(alignment: .leading, spacing: 10) {
                Text(LocalizedStringKey(""))
                Text(LocalizedStringKey("st_how_to_start_title"))
                    .font(.headline)
                    .foregroundColor(.blue)

                Text(LocalizedStringKey("st_instruction_step1"))
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("st_instruction_bullet1"))
                    Text(LocalizedStringKey("st_instruction_bullet2"))
                }
                .font(.callout)
                .foregroundColor(.gray)

                Text(LocalizedStringKey("st_instruction_step2"))
                    .font(.body)

                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("st_instruction_bullet3"))
                    Text(LocalizedStringKey("st_instruction_bullet4"))
                    Text(LocalizedStringKey("st_instruction_bullet5"))
                    Text(LocalizedStringKey("st_instruction_bullet6"))
                    Text(LocalizedStringKey(""))
                }
                .font(.callout)
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 20)

            // Start Task Button
            NavigationLink(
                destination: TaskView(
                    currentWord: currentWord,
                    isCheatSheetEnabled: wordStore.isCheatSheetEnabled,
                    isRandomizeDiceEnabled: wordStore.isRandomizeDiceEnabled,
                    wordStore: wordStore
                )
                .environmentObject(wordStore),
                isActive: $navTrigger
            ) {
                PastelButton(
                    title: LocalizedStringKey("st_start_task"),
                    colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            .simultaneousGesture(
                TapGesture().onEnded {
                    if currentWord.isEmpty || currentWord == "No word" {
                        currentWord = wordStore.getRandomWord()
                    }
                    print("StartView: currentWord before Navigation = \(currentWord)")
                    navTrigger = true
                }
            )
            
            // View Points Button – pass localAchievements to PointsView
            NavigationLink(destination: PointsView(achievements: localAchievements)
                            .environmentObject(wordStore)) {
                PastelButton(
                    title: LocalizedStringKey("st_view_points"),
                    colors: [Color.pink.opacity(0.6), Color.orange.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            // Manual Button
            NavigationLink(destination: ManualsView()) {
                PastelButton(
                    title: LocalizedStringKey("st_manuals"),
                    colors: [Color.yellow.opacity(0.6), Color.cyan.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
        .onAppear {
            wordStore.incrementDailyUsage()
            print("Daily Usage Streak: \(wordStore.dailyUsageStreak)")
            print("StartView appeared! Current word: \(currentWord)")
            // Subscribe to changes in WordStore's achievements & runtimeAchievements and update localAchievements.
            achievementsCancellable = Publishers.CombineLatest(wordStore.$achievements, wordStore.$runtimeAchievements)
                .map { persistent, runtime in
                    // Compute effective achievements as OR of persistent and runtime arrays.
                    zip(persistent, runtime).map { $0 || $1 }
                }
                .sink { updated in
                    localAchievements = updated
                    print("StartView updated localAchievements: \(localAchievements)")
                }
        }
        .onDisappear {
            print("StartView disappeared unexpectedly! Current word: \(currentWord)")
            achievementsCancellable?.cancel()
        }
    }
}
