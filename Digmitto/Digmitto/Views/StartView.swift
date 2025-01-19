import SwiftUI

struct StartView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var currentWord: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // General Action Text
            Text(LocalizedStringKey("st_general"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .foregroundColor(.purple.opacity(0.7))
            
            Spacer()
            
            // Start Task Button
            NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: wordStore.isCheatSheetEnabled, wordStore: wordStore)) {
                PastelButton(
                    title: LocalizedStringKey("st_start_task"),
                    colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            .simultaneousGesture(TapGesture().onEnded {
                currentWord = wordStore.getRandomWord()
            })
            
            // View Points Button
            NavigationLink(destination: PointsView()) {
                PastelButton(
                    title: LocalizedStringKey("st_view_points"),
                    colors: [Color.pink.opacity(0.6), Color.orange.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            // Manual Button
            NavigationLink(destination: GuideWalkthroughView()) {
                PastelButton(
                    title: LocalizedStringKey("st_manual"),
                    colors: [Color.yellow.opacity(0.6), Color.cyan.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}

struct PastelButton: View {
    let title: LocalizedStringKey
    let colors: [Color]
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(WordStore())
    }
}
