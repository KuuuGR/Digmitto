import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack {
            Text("Digmitto")
                .font(.largeTitle)
                .padding()
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Button(action: {
                // Navigate to Task Screen
            }) {
                Text("Start")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
            Text("ver. 0.0.1")
                .font(.footnote)
                .padding()
        }
    }
} 