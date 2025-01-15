import SwiftUI

class WordStore: ObservableObject {
    @Published var words: [String: [String]] = [:]
    @Published var selectedLanguage: String = "English" {
        didSet {
            UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
        }
    }
    @Published var enableColorization: Bool = false {
        didSet {
            UserDefaults.standard.set(enableColorization, forKey: "enableColorization")
        }
    }
    @Published var primaryColor: Color = .blue {
        didSet {
            UserDefaults.standard.setColor(primaryColor, forKey: "primaryColor")
        }
    }
    @Published var secondaryColor: Color = .gray {
        didSet {
            UserDefaults.standard.setColor(secondaryColor, forKey: "secondaryColor")
        }
    }
    @Published var defaultColor: Color = .white {
        didSet {
            UserDefaults.standard.setColor(defaultColor, forKey: "defaultColor")
        }
    }
    @Published var majorSystemLetters: String = "sztdnmrljkgfwpbSZTDNMRLJKGFWPB" {
        didSet {
            UserDefaults.standard.set(majorSystemLetters, forKey: "majorSystemLetters")
        }
    }
    @Published var isCheatSheetEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(isCheatSheetEnabled, forKey: "isCheatSheetEnabled")
        }
    }
    @Published var totalPoints: Int = 0 {
        didSet {
            UserDefaults.standard.set(totalPoints, forKey: "totalPoints")
        }
    }
    
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
        loadSettings()
        totalPoints = UserDefaults.standard.integer(forKey: "totalPoints")
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
    
    func loadSettings() {
        selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "English"
        enableColorization = UserDefaults.standard.bool(forKey: "enableColorization")
        primaryColor = UserDefaults.standard.color(forKey: "primaryColor") ?? .blue
        secondaryColor = UserDefaults.standard.color(forKey: "secondaryColor") ?? .gray
        defaultColor = UserDefaults.standard.color(forKey: "defaultColor") ?? .white
        majorSystemLetters = UserDefaults.standard.string(forKey: "majorSystemLetters") ?? "sztdnmrljkgfwpbSZTDNMRLJKGFWPB"
        isCheatSheetEnabled = UserDefaults.standard.bool(forKey: "isCheatSheetEnabled")
    }
}

// Extension to handle Color storage in UserDefaults
extension UserDefaults {
    func setColor(_ color: Color, forKey key: String) {
        let uiColor = UIColor(color)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: true)
            set(data, forKey: key)
        } catch {
            print("Failed to save color to UserDefaults: \(error)")
        }
    }
    
    func color(forKey key: String) -> Color? {
        guard let data = data(forKey: key) else { return nil }
        do {
            if let uiColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
                return Color(uiColor)
            }
        } catch {
            print("Failed to load color from UserDefaults: \(error)")
        }
        return nil
    }
}
