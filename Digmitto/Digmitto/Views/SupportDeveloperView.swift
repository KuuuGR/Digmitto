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

            Spacer()
        }
        .padding()
    }
}
