import SwiftUI

struct PointsView: View {
    @EnvironmentObject var wordStore: WordStore

    var body: some View {
        VStack {
            Text("Total Points")
                .font(.largeTitle)
                .padding(.top, 40)
            
            Text("\(wordStore.totalPoints)")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Points")
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
            .environmentObject(WordStore())
    }
} 