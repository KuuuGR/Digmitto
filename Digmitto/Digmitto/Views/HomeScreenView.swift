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
        Color(red: 150/255, green: 240/255, blue: 255/255),
        Color(red: 255/255, green: 159/255, blue: 200/255),
        Color(red: 200/255, green: 200/255, blue: 187/255)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Top content
                    VStack {
                        Image("iconDigit1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 40)
                            .opacity(0.2)
                        
                        Text(LocalizedStringKey("welcome_message"))
                            .font(.largeTitle)
                            .padding()

                        Spacer()

                        // Fancy start button
                        NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: isCheatSheetVisible)) {
                            ZStack {
                                Circle()
                                    .fill(buttonColors[0])
                                    .frame(width: 160, height: 160)
                                    .opacity(0.4)
                                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                                
                                VStack(spacing: 5) {
                                    Text("⭐️")
                                        .font(.system(size: 50))
                                    Text(LocalizedStringKey("start_button"))
                                        .font(.system(size: 20))
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                    }
                    
                    // Bottom navigation buttons
                    VStack {
                        HStack(spacing: 15) {
                            NavigationButton(title: "About", color: buttonColors[2], destination: AboutView())
                            NavigationButton(title: LocalizedStringKey("settings_title"), color: buttonColors[1], destination: SettingsView(isCheatSheetVisible: $isCheatSheetVisible))
                            NavigationButton(title: "Developer", color: buttonColors[2], destination: DeveloperView())
                        }
                        .padding(.horizontal)
                        .opacity(0.4)
                        .padding(.bottom, 30) // Increased bottom padding
                    }
                    .background(
                        Color(UIColor.systemBackground)
                            .edgesIgnoringSafeArea(.bottom)
                            .shadow(color: .gray.opacity(0.1), radius: 8, y: -4)
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
                .frame(height: 44)
                .background(color)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(WordStore())
    }
} 
