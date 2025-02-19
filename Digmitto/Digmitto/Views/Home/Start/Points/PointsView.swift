import SwiftUI

struct PointsView: View {
    // Instead of reading directly from WordStore, we accept achievements as a constant.
    let achievements: [Bool]
    @EnvironmentObject var wordStore: WordStore  // For points and other data
    
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
                .font(.system(.title2, design: .monospaced)) // Monospace font for terminal effect
                .fontWeight(.semibold)
                .foregroundColor(Color.green) // Set color to green
                .padding(.bottom, 10)
                .opacity(0.4)
            
            // Achievements Section
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<achievements.count, id: \.self) { index in
                        AchievementRow(index: index)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(LocalizedStringKey("pw_title"))
        .onAppear {
            print("Daily Usage Streak: \(wordStore.dailyUsageStreak)")
        }
    }
    
    // MARK: - Achievement Row Component
    @ViewBuilder
    private func AchievementRow(index: Int) -> some View {
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
    
    // MARK: - Achievement Image
    private func achievementImage(for index: Int) -> some View {
        Image(achievements[index] ? "ach_\(index)" : "ach_empty_\(index)")
            .resizable()
            .scaledToFit()
            .opacity(0.7)
            .frame(width: frameWidth, height: frameHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.green, lineWidth: borderWidth)
                    .opacity(0.4)
            )
    }
    
    // MARK: - Achievement Description
    private func achievementDescription(for index: Int) -> some View {
        Text(getLocalizedDescription(for: index))
            .font(.system(.body, design: .monospaced)) // Monospace font for retro feel
            .foregroundColor(Color.green) // Green color for old computer effect
            .multilineTextAlignment(.leading)
            .padding(.leading, 10)
            .opacity(0.4)
    }
    
    // Helper function to fetch the localized description
    private func getLocalizedDescription(for index: Int) -> String {
        NSLocalizedString("ach_description_\(index)", comment: "")
    }
}
