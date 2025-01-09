import SwiftUI

class WordStore: ObservableObject {
    @Published var words = ["motormotorT", "tabletableB", "gardengardenX"]
    
    func getRandomWord() -> String {
        words.randomElement() ?? "motor"
    }
} 
