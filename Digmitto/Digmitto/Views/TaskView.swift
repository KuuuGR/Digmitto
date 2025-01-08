import SwiftUI

struct TaskView: View {
    var currentWord: String

    var body: some View {
        Text("Current Word: \(currentWord)")
            .font(.largeTitle)
            .padding()
    }
} 