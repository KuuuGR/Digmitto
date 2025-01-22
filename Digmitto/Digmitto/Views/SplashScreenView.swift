import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var logoOpacity: Double = 0.1 // starting opacity

    var body: some View {
        if isActive {
            HomeScreenView() // Ensure HomeScreenView is also defined
        } else {
            ZStack {
                Color.black // Set background color to black
                    .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen
                
                VStack {
                    Spacer() // Push content to the center vertically
                    
                    Image("logo") // Ensure you have a logo image in your assets
                        .resizable()
                        .scaledToFit() // Ensure the image keeps its aspect ratio
                        .frame(maxWidth: .infinity) // Extend to the screen width
                        .opacity(logoOpacity) // Bind opacity to state variable
                        .cornerRadius(220) // Round corners
                        .onAppear {
                            // Gradually increase the opacity over 2 seconds
                            withAnimation(.easeIn(duration: 2)) {
                                logoOpacity = 0.9
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.isActive = true
                                }
                            }
                        }
                    
                    Spacer() // Push content to the center vertically
                }
            }
        }
    }
}
