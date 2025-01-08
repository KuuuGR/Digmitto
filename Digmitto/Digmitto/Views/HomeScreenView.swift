import SwiftUI

struct HomeScreenView: View {
    @State private var words = ["motor", "table", "lamp"]
    @State private var currentWord = "motor"

    var body: some View {
        NavigationView {
            VStack {
                Text(LocalizedStringKey("welcome_message"))
                    .font(.largeTitle)
                    .padding()

                Spacer()

                NavigationLink(destination: TaskView(currentWord: currentWord)) {
                    Text(LocalizedStringKey("start_button"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: SettingsView()) {
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
            .onAppear {
                currentWord = words.randomElement() ?? "motor"
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
} 