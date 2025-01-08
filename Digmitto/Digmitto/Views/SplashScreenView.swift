import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeScreenView() // Ensure HomeScreenView is also defined
        } else {
            ZStack {
                Color.black // Set background color to black
                    .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen
                Image("logo") // Ensure you have a logo image in your assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .opacity(0.7) // Set logo opacity to 70%
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}