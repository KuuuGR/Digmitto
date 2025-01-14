import SwiftUI

struct CheatSheetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Major System Cheat Sheet")
                .font(.headline)
                .padding(.bottom, 5)
            Text("0: s, z")
                .font(.body)
            Text("1: t, d")
                .font(.body)
            Text("2: n")
                .font(.body)
            Text("3: m")
                .font(.body)
            Text("4: r")
                .font(.body)
            Text("5: l")
                .font(.body)
            Text("6: j")
                .font(.body)
            Text("7: k, g")
                .font(.body)
            Text("8: f, w")
                .font(.body)
            Text("9: p, b")
                .font(.body)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .navigationTitle("Cheat Sheet")
    }
}

struct CheatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CheatSheetView()
    }
} 
