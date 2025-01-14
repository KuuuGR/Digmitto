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
                        HomeButton(title: "Start", gradient: LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        HomeButton(title: "Settings", gradient: LinearGradient(gradient: Gradient(colors: [.gray, .black.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    }
                    
                    NavigationLink(destination: AboutView()) {
                        HomeButton(title: "About", gradient: LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.6), .gray]), startPoint: .leading, endPoint: .trailing))
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
    let gradient: LinearGradient
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(gradient)
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
