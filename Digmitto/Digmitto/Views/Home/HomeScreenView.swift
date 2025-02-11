import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var navigateToDestination: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Welcome Message
                Text(LocalizedStringKey("hs_welcome"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()

                // Start Button
                Button(action: {
                    navigateToDestination = true
                }) {
                    HomeButton(
                        title: LocalizedStringKey("hs_start_button"),
                        gradient: LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                }
                .background(
                    NavigationLink(
                        destination: wordStore.hasSeenManual ? AnyView(StartView()) : AnyView(FirstManualView()),
                        isActive: $navigateToDestination
                    ) {
                        EmptyView()
                    }
                    .hidden()
                )

                // Settings Button
                NavigationLink(destination: SettingsView()) {
                    HomeButton(
                        title: LocalizedStringKey("hs_settings_button"),
                        gradient: LinearGradient(
                            gradient: Gradient(colors: [.gray, .black.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                }

                // About Button
                NavigationLink(destination: AboutView()) {
                    HomeButton(
                        title: LocalizedStringKey("hs_about_button"),
                        gradient: LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.6), .gray]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                }
                
                // Total Points Display
                Text(String(format: NSLocalizedString("hs_total_points_format", comment: ""), wordStore.totalPoints))
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
    let title: LocalizedStringKey
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
