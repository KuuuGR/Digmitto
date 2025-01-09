import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var currentWord = ""
    @State private var isCheatSheetVisible = true
    
    // Get version and build number from Info.plist
    private var versionNumber: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "v\(version) (\(build))"
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("iconDigit1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 40)
                        .opacity(0.25)
                    
                    Text(LocalizedStringKey("welcome_message"))
                        .font(.largeTitle)
                        .padding()

                    Spacer()

                    Text("⇩") //👇⭐️⬇️↓
                        .font(.system(size: 100))
                        .padding()

                    NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: isCheatSheetVisible)) {
                        Text(LocalizedStringKey("start_button"))
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                    NavigationLink(destination: SettingsView(isCheatSheetVisible: $isCheatSheetVisible)) {
                        Text(LocalizedStringKey("settings_title"))
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding()

                    Spacer()
                }
                
                // Version label in bottom-right corner
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

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(WordStore())
    }
} 
