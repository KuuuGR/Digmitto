import SwiftUI

struct CheatSheetView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(LocalizedStringKey("cs_title"))
                    .font(.headline)
                    .foregroundColor(.brown)
                    .padding(.bottom, 5)

                VStack(alignment: .leading, spacing: 8) {
                    Text("0: s, z").font(.body)
                    Text("1: t, d").font(.body)
                    Text("2: n").font(.body)
                    Text("3: m").font(.body)
                    Text("4: r").font(.body)
                    Text("5: l").font(.body)
                    Text("6: j").font(.body)
                    Text("7: k, g").font(.body)
                    Text("8: f, w").font(.body)
                    Text("9: p, b").font(.body)
                }
                .padding()
            }
            .frame(maxWidth: .infinity) // Ensures the content uses full width
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 2, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.brown, lineWidth: 4)
        )
    }
}

//struct CheatSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheatSheetView()
//            .frame(width: 300, height: 150) // Reduced frame for preview
//    }
//}
