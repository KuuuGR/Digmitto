import SwiftUI

struct TaskScreenView: View {
    @State private var selectedWord = "motor"
    @State private var userInput = ""
    
    var body: some View {
        VStack {
            Button("Back") {
                // Navigate back
            }
            .padding()
            
            Text(selectedWord)
                .font(.largeTitle)
                .padding()
            
            // Add sliders and input validation logic here
            
            Button("Code") {
                // Validate input
            }
            .padding()
        }
    }
} 