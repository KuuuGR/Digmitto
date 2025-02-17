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
    @Published var isRandomizeDiceEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(isRandomizeDiceEnabled, forKey: "isRandomizeDiceEnabled")
        }
    }
    @Published var totalPoints: Int = 0 {
        didSet {
            checkAchievements() // Check achievements when points change
            UserDefaults.standard.set(totalPoints, forKey: "totalPoints")
        }
    }
    @Published var achievements: [Bool] = Array(repeating: false, count: 9) {
        didSet {
            saveAchievements()
        }
    }
    // This array is only for the current session.
    @Published var runtimeAchievements: [Bool] = Array(repeating: false, count: 9)

    // Computed property returns true at an index if either persistent or runtime achievement is true.
    var effectiveAchievements: [Bool] {
        zip(achievements, runtimeAchievements).map { $0 || $1 }
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
    @Published var fruitsCollectedInSession: Set<String> = []  // Resets every session
    @Published var allTimeCollectedFruits: Set<String> = [] {  // Persistent across sessions
        didSet {
            saveAllTimeCollectedFruits()
        }
    }


    // ✅ Re-added missing letterToNumberMap
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
    
    @Published var hasSeenManual: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenManual, forKey: "hasSeenManual")
        }
    }

    // MARK: - Constructor

    init() {
        hasSeenManual = UserDefaults.standard.bool(forKey: "hasSeenManual")
        
        loadWords()
        loadSettings()
        totalPoints = UserDefaults.standard.integer(forKey: "totalPoints")
        loadAchievements()
        loadRemainingFruits()
        dailyUsageStreak = UserDefaults.standard.integer(forKey: "dailyUsageStreak")
        
        // Load collected fruits across all sessions (persistent)
        if let savedFruits = UserDefaults.standard.array(forKey: "allTimeCollectedFruits") as? [String] {
            allTimeCollectedFruits = Set(savedFruits)
        }
        
        // Call checkAchievements once after loading all persistent data
        checkAchievements()
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
        guard let languageWords = words[selectedLanguage], !languageWords.isEmpty else {
            print("WordStore: No words found for the selected language. Using default.")
            return "Placeholder"
        }
        return languageWords.randomElement() ?? "Placeholder"
    }
    
    func numberForLetter(_ letter: String) -> String {
        return letterToNumberMap[Character(letter)] ?? "0"
    }

    // MARK: - Achievements Management

    private func saveAchievements() {
        print("Saving achievements: \(achievements)")
        UserDefaults.standard.set(achievements, forKey: "achievements")
    }
    
    private func loadAchievements() {
        if let savedAchievements = UserDefaults.standard.array(forKey: "achievements") as? [Bool] {
            // Ensure the achievements array always has 9 elements:
            achievements = Array(savedAchievements.prefix(9)) + Array(repeating: false, count: max(0, 9 - savedAchievements.count))
            // Force coconut achievement if allTimeCollectedFruits contains the coconut
            if allTimeCollectedFruits.contains("🥥") {
                achievements[8] = true
                print("Loaded achievements: Coconut Collector forced UNLOCKED because allTimeCollectedFruits contains 🥥")
            }
            print("Loaded achievements: \(achievements)")
        } else {
            print("No saved achievements found, initializing achievements to false.")
            achievements = Array(repeating: false, count: 9)
        }
    }
    
    func unlockAchievement(at index: Int) {
        guard index >= 0 && index < achievements.count else { return }
        achievements[index] = true
        print("Unlocked achievement at index \(index). Achievements now: \(achievements)")
    }

    func checkAchievements() {
        print("Checking achievements...")
        
        // Ensure there are at least 9 achievement slots.
        var newAchievements = achievements
        if newAchievements.count < 9 {
            newAchievements = Array(newAchievements.prefix(9)) + Array(repeating: false, count: max(0, 9 - newAchievements.count))
        }
        
        // Example achievement conditions:
        // Champion: Reach 500 points
        if totalPoints >= 500 {
            newAchievements[0] = true
            print("Champion achievement unlocked!")
        }

        // First Steps: Complete your first task
        if totalPoints >= 1 {
            newAchievements[1] = true
            print("First Steps achievement unlocked!")
        }

        // Memory Master: Reach 100 points
        if totalPoints >= 100 {
            newAchievements[2] = true
            print("Memory Master achievement unlocked!")
        }
        
        // Speed Demon: 10 tasks in session under 60 seconds
        if tasksCompletedInSession >= 10, let startTime = sessionStartTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime <= 60 {
                newAchievements[3] = true
                print("Speed Demon achievement unlocked!")
            }
        }
        
        // Perfect Session: 10 tasks and zero mistakes
        if tasksCompletedInSession >= 10, currentSessionMistakes == 0 {
            newAchievements[4] = true
            print("Perfect Session achievement unlocked!")
        }
        
        // Consistent Learner: Use the app daily for a week
        if dailyUsageStreak >= 7 {
            newAchievements[5] = true
            print("Consistent Learner achievement unlocked!")
        }

        // Fruit Collector: All fruits collected across sessions
        if remainingFruits.isEmpty {
            newAchievements[6] = true
            print("Fruit Collector achievement unlocked!")
        } else {
            print("Remaining fruits for Fruit Collector: \(remainingFruits)")
        }

        // Grocery Seller: All fruits collected in a single session
        let allFruits: Set<String> = ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"]
        if fruitsCollectedInSession == allFruits {
            newAchievements[7] = true
            print("Grocery Seller achievement unlocked!")
        } else {
            print("Fruits collected in session: \(fruitsCollectedInSession)")
        }
        
        // Coconut Collector: Obtain a coconut fruit at least once
        if allTimeCollectedFruits.contains("🥥") {
            newAchievements[8] = true
            print("Coconut Collector achievement unlocked!")
        }
        
        // Update the published arrays if there is any change.
        if newAchievements != achievements {
            // Force SwiftUI to send an update.
            objectWillChange.send()
            achievements = newAchievements
        }
        
        // Also update our runtime achievements.
        runtimeAchievements = newAchievements
        
        // Save persistent achievements.
        saveAchievements()
    }

    // MARK: - Fruit Management
    func collectFruit(_ fruit: String) {
        print("Collecting fruit: \(fruit)")
        fruitsCollectedInSession.insert(fruit)  // Track for single session
        allTimeCollectedFruits.insert(fruit)  // Track for all-time collection
        remainingFruits.remove(fruit)
        print("All-time collected fruits: \(allTimeCollectedFruits)")
        saveAllTimeCollectedFruits()  // Save collected fruits permanently
        checkAchievements()           // Re-check achievements
    }

    private func saveAllTimeCollectedFruits() {
        UserDefaults.standard.set(Array(allTimeCollectedFruits), forKey: "allTimeCollectedFruits")
    }

    private func saveRemainingFruits() {
        UserDefaults.standard.set(Array(remainingFruits), forKey: "remainingFruits")
    }

    private func loadRemainingFruits() {
        if let savedFruits = UserDefaults.standard.array(forKey: "remainingFruits") as? [String] {
            remainingFruits = Set(savedFruits)
        }
    }
    
    private func loadAllTimeCollectedFruits() {
        if let savedFruits = UserDefaults.standard.array(forKey: "allTimeCollectedFruits") as? [String] {
            allTimeCollectedFruits = Set(savedFruits)
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
        isRandomizeDiceEnabled = UserDefaults.standard.bool(forKey: "isRandomizeDiceEnabled")
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
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: true) {
            set(data, forKey: key)
        }
    }

    func color(forKey key: String) -> Color? {
        guard let data = data(forKey: key) else { return nil }
        if let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
            return Color(uiColor)
        }
        return nil
    }
}
