import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var wordStore: WordStore

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Major Memory System")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    NavigationLink(destination: StartView()) {
                        HomeButton(title: "Start")
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        HomeButton(title: "Settings")
                    }
                    
                    NavigationLink(destination: AboutView()) {
                        HomeButton(title: "About")
                    }
                }
                
                Text("Total Points: \(wordStore.totalPoints)")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .navigationBarHidden(true)
        }
    }
}

struct HomeButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(WordStore())
    }
}
