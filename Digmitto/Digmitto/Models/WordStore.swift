import SwiftUI

class WordStore: ObservableObject {
    @Published var words = ["motor", "table", "garden"]
    
    func getRandomWord() -> String {
        words.randomElement() ?? "motor"
    }
} 