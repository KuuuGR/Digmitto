import SwiftUI

class WordStore: ObservableObject {
    @Published var words: [String: [String]] = [:]
    @Published var selectedLanguage: String = "English"
    @Published var enableColorization: Bool = false
    @Published var primaryColor: Color = .blue
    @Published var secondaryColor: Color = .gray
    @Published var defaultColor: Color = .white
    @Published var majorSystemLetters: String = "sztdnmrljkgfwpbSZTDNMRLJKGFWPB"
    
    // Corrected mapping with double quotes for character literals
    private let letterToNumberMap: [Character: String] = [
        "s": "0", "z": "0", "S": "0", "Z": "0",
        "t": "1", "d": "1", "T": "1", "D": "1",
        "n": "2", "N": "2",
        "m": "3", "M": "3",
        "r": "4", "R": "4",
        "l": "5", "L": "5",
        "j": "6", "J": "6",
        "k": "7", "g": "7", "K": "7", "G": "7",
        "f": "8", "w": "8", "F": "8", "W": "8",
        "p": "9", "b": "9", "P": "9", "B": "9",
    ]
    
    init() {
        loadWords()
    }
    
    func loadWords() {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([String: [String]].self, from: data) {
                words = jsonData
            } else {
                print("Failed to decode JSON data")
            }
        } else {
            print("Failed to load JSON file")
        }
    }
    
    func getRandomWord() -> String {
        guard let languageWords = words[selectedLanguage] else {
            return "No word"
        }
        return languageWords.randomElement() ?? "No word"
    }
    
    func numberForLetter(_ letter: String) -> String {
        guard let number = letterToNumberMap[Character(letter)] else {
            return "0"  // Default or error value
        }
        return number
    }
}
