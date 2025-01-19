import SwiftUI

struct PointsView: View {
    @EnvironmentObject var wordStore: WordStore
    
    // Customization properties
    let frameWidth: CGFloat = 100
    let frameHeight: CGFloat = 100
    let cornerRadius: CGFloat = 12
    let borderColor: Color = .gray
    let borderWidth: CGFloat = 2

    var body: some View {
        VStack {
            // Total Points Section
            Text(LocalizedStringKey("pw_total"))
                .font(.largeTitle)
                .padding(.top, 40)
            
            Text("\(wordStore.totalPoints)")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding()
            
            // Line separator
            Divider()
                .padding(.vertical, 10)
            
            // Achievements Section Title
            Text(LocalizedStringKey("pw_achievements"))
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            // Achievements Section
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<wordStore.achievements.count, id: \.self) { index in
                        HStack(spacing: 20) {
                            if index % 2 == 0 {
                                // Image on the left, text on the right
                                achievementImage(for: index)
                                achievementDescription(for: index)
                            } else {
                                // Text on the left, image on the right
                                achievementDescription(for: index)
                                achievementImage(for: index)
                            }
                        }
                        .padding()
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(LocalizedStringKey("pw_title"))
    }
    
    // Function to get the achievement image with customizable frame and border
    private func achievementImage(for index: Int) -> some View {
        Image(wordStore.achievements[index] ? "ach_\(index)" : "ach_empty_\(index)")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth, height: frameHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
    
    // Function to get the localized achievement description
    private func achievementDescription(for index: Int) -> some View {
        Text(getLocalizedDescription(for: index))
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding(.leading, 10)
    }
    
    // Helper function to fetch the localized description
    private func getLocalizedDescription(for index: Int) -> String {
        return NSLocalizedString("ach_description_\(index)", comment: "")
    }
}

//struct PointsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PointsView()
//            .environmentObject(WordStore())
//    }
//}
