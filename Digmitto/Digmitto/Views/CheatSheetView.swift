import SwiftUI

struct CheatSheetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Major System Cheat Sheet")
                .font(.headline)
                .padding(.bottom, 5)
            Text("0: s, z")
            Text("1: t, d")
            Text("2: n")
            Text("3: m")
            Text("4: r")
            Text("5: l")
            Text("6: j, sz, cz")
            Text("7: k, g")
            Text("8: f, w")
            Text("9: p, b")
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