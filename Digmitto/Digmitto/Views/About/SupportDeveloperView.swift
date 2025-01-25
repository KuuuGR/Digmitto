import SwiftUI

struct SupportDeveloperView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("sd_support_title"))
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text(LocalizedStringKey("sd_support_message"))
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text(LocalizedStringKey("sd_support_voluntary"))
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                if let url = URL(string: "https://www.paypal.me/etaosin") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(LocalizedStringKey("sd_support_button"))
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)

            
            Button(action: {
                withAnimation {
                    if let url = URL(string: "https://www.paypal.me/etaosin") {
                        UIApplication.shared.open(url)
                    }
                }
            }) {
                Image("Paypal_2014_logo")
                    .resizable()
                    .scaledToFit() // Ensures the image scales proportionally
                    .frame(width: 40, height: 40) // Adjust this size to fit the button dimensions
                    .padding(10) // Slight padding for a better look
                    .background(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10) // Matches the button's corner radius
                    .shadow(radius: 5)
            }
            .frame(width: 60, height: 60) // The button's overall size
            .padding(.bottom, 5)
                        
            Spacer()
        }
        .padding()
    }
}
