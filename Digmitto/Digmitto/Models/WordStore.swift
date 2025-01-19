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
            checkAchievements() // Check achievements when points change
            UserDefaults.standard.set(totalPoints, forKey: "totalPoints")
        }
    }
    @Published var achievements: [Bool] = Array(repeating: false, count: 8) {
        didSet {
            saveAchievements()
        }
    }
    @Published var dailyUsageStreak: Int = 0 {
        didSet {
            UserDefaults.standard.set(dailyUsageStreak, forKey: "dailyUsageStreak")
        }
    }
    @Published var currentSessionMistakes: Int = 0
    @Published var tasksCompletedInSession: Int = 0
    @Published var sessionStartTime: Date?
    @Published var remainingFruits: Set<String> = Set(["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"]) {
        didSet {
            saveRemainingFruits()
        }
    }
    @Published var fruitsCollectedInSession: Set<String> = []

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
        loadAchievements()
        loadRemainingFruits()
        dailyUsageStreak = UserDefaults.standard.integer(forKey: "dailyUsageStreak")
    }
    
    // MARK: - Words Management
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

    // MARK: - Achievements Management
    private func saveAchievements() {
        UserDefaults.standard.set(achievements, forKey: "achievements")
    }
    
    private func loadAchievements() {
        if let savedAchievements = UserDefaults.standard.array(forKey: "achievements") as? [Bool] {
            // Ensure the array has 8 elements
            achievements = Array(savedAchievements.prefix(8)) + Array(repeating: false, count: max(0, 8 - savedAchievements.count))
        }
    }
    
    func unlockAchievement(at index: Int) {
        guard index >= 0 && index < achievements.count else { return }
        achievements[index] = true
    }

    func checkAchievements() {
        print("Checking achievements...")
        
        // Champion: Reach 500 points
        if totalPoints >= 500 {
            achievements[0] = true
            print("Champion achievement unlocked!")
        }

        // First Steps: Complete your first task
        if totalPoints >= 1 {
            achievements[1] = true
            print("First Steps achievement unlocked!")
        }

        // Memory Master: Reach 100 points
        if totalPoints >= 100 {
            achievements[2] = true
            print("Memory Master achievement unlocked!")
        }
        
        // Speed Demon
        if tasksCompletedInSession >= 10, let startTime = sessionStartTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime <= 60 {
                achievements[3] = true
            }
        }
        
        // Perfect Session
        if tasksCompletedInSession == 10, currentSessionMistakes == 0 {
            achievements[4] = true
        }
        
        // Consistent Learner: Use the app daily for a week
        if dailyUsageStreak >= 7 {
            achievements[5] = true
            print("Consistent Learner achievement unlocked!")
        }

        // Fruit Collector: All fruits collected across sessions
        if remainingFruits.isEmpty {
            achievements[6] = true
            print("Fruit Collector achievement unlocked!")
        } else {
            print("Remaining fruits for Fruit Collector: \(remainingFruits)")
        }

        // Grocery Seller: All fruits collected in a single session
        let allFruits = Set(["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"])
        if fruitsCollectedInSession == allFruits {
            achievements[7] = true
            print("Grocery Seller achievement unlocked!")
        } else {
            print("Fruits collected in session: \(fruitsCollectedInSession)")
        }
    }

    // MARK: - Fruit Management
    func collectFruit(_ fruit: String) {
        print("Collecting fruit: \(fruit)")
        fruitsCollectedInSession.insert(fruit)
        remainingFruits.remove(fruit)
        print("Remaining fruits: \(remainingFruits)")
        checkAchievements()
    }

    private func saveRemainingFruits() {
        UserDefaults.standard.set(Array(remainingFruits), forKey: "remainingFruits")
    }

    private func loadRemainingFruits() {
        if let savedFruits = UserDefaults.standard.array(forKey: "remainingFruits") as? [String] {
            remainingFruits = Set(savedFruits)
        }
    }

    // MARK: - Settings Management
    private func loadSettings() {
        selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "English"
        enableColorization = UserDefaults.standard.bool(forKey: "enableColorization")
        primaryColor = UserDefaults.standard.color(forKey: "primaryColor") ?? .blue
        secondaryColor = UserDefaults.standard.color(forKey: "secondaryColor") ?? .gray
        defaultColor = UserDefaults.standard.color(forKey: "defaultColor") ?? .white
        majorSystemLetters = UserDefaults.standard.string(forKey: "majorSystemLetters") ?? "sztdnmrljkgfwpbSZTDNMRLJKGFWPB"
        isCheatSheetEnabled = UserDefaults.standard.bool(forKey: "isCheatSheetEnabled")
    }

    // MARK: - Daily Usage
    func incrementDailyUsage() {
        let lastUsageDate = UserDefaults.standard.object(forKey: "lastUsageDate") as? Date ?? Date.distantPast
        if !Calendar.current.isDateInToday(lastUsageDate) {
            dailyUsageStreak += 1
            UserDefaults.standard.set(Date(), forKey: "lastUsageDate")
        }
    }
}

// MARK: - UserDefaults Extension
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
