import SwiftUI

struct StartView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var currentWord: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Your Action")
                .font(.largeTitle)
                .padding(.top, 40)
            
            Spacer()
            
            NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: wordStore.isCheatSheetEnabled, wordStore: wordStore)) {
                Text("Start Task")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .simultaneousGesture(TapGesture().onEnded {
                currentWord = wordStore.getRandomWord()
            })
            
            NavigationLink(destination: PointsView()) {
                Text("View Points")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            
            NavigationLink(destination: TutorialView()) {
                Text("Tutorial")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(WordStore())
    }
} 