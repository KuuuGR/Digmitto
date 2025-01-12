import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var currentWord = ""
    @State private var isCheatSheetVisible = true
    
    private var versionNumber: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "v\(version) (\(build))"
    }
    
    private let buttonColors = [
        Color.green.opacity(0.8),
        Color.pink.opacity(0.8),
        Color.gray.opacity(0.7),
        Color.blue.opacity(0.8)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Background effect
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Material.regular)

                VStack(spacing: 0) {
                    // Top content
                    VStack {
                        Image("iconDigit1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .padding(.top, 40)
                            .opacity(0.25)
                        
                        Text(LocalizedStringKey("welcome_message"))
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.primary)

                        Spacer()

                        // Enhanced start button
                        NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: isCheatSheetVisible, wordStore: wordStore)) {
                            ZStack {
                                Circle()
                                    .fill(buttonColors[0])
                                    .frame(width: 170, height: 170)
                                    .shadow(color: .green.opacity(0.5), radius: 20, x: 0, y: 10)
                                Circle()
                                    .fill(buttonColors[0])
                                    .frame(width: 160, height: 160)
                                VStack(spacing: 8) {
                                    Text("⭐️")
                                        .font(.system(size: 50))
                                    Text(LocalizedStringKey("start_button"))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                    }
                    
                    // Bottom navigation buttons
                    VStack(spacing: 20) {
                        HStack(spacing: 15) {
                            NavigationButton(title: "About", color: buttonColors[2], destination: AboutView())
                            NavigationButton(title: LocalizedStringKey("settings_title"), color: buttonColors[1], destination: SettingsView(isCheatSheetVisible: $isCheatSheetVisible))
                        }
                        
                        HStack(spacing: 15) {
                            NavigationButton(title: "Developer", color: buttonColors[2], destination: DeveloperView())
                            NavigationButton(title: "Tutorial", color: buttonColors[3], destination: TutorialView())
                        }
                    }
                    .padding()
                    .background(
                        Color(UIColor.systemBackground)
                            .shadow(color: .gray.opacity(0.2), radius: 8, y: -4)
                    )
                }
                
                // Version label
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(versionNumber)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding([.bottom, .trailing], 8)
                    }
                }
            }
            .onAppear {
                currentWord = wordStore.getRandomWord()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationButton<Destination: View>: View {
    let title: LocalizedStringKey
    let color: Color
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(color)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

struct TutorialView: View {
    var body: some View {
        Text("Tutorial content goes here!")
            .font(.title)
            .padding()
    }
}

//struct HomeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreenView()
//            .environmentObject(WordStore())
//    }
//}
