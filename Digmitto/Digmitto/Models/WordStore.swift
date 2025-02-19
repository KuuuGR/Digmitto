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
    
    // Persistent achievements array.
    @Published var achievements: [Bool] = Array(repeating: false, count: 9) {
        didSet { saveAchievements() }
    }
    // This array is only for the current session.
    @Published var runtimeAchievements: [Bool] = Array(repeating: false, count: 9)
    
    // Computed property: an achievement is unlocked if it's true in either array.
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
        didSet { saveRemainingFruits() }
    }
    @Published var fruitsCollectedInSession: Set<String> = []  // Resets every session
    // Persistent across sessions.
    @Published var allTimeCollectedFruits: Set<String> = [] {
        didSet { saveAllTimeCollectedFruits() }
    }
    
    // MARK: - Letter-to-Number Map
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
        
        // Load persistent all-time fruits.
        if let savedFruits = UserDefaults.standard.array(forKey: "allTimeCollectedFruits") as? [String] {
            allTimeCollectedFruits = Set(savedFruits)
        }
        
        // Call checkAchievements() once after loading persistent data.
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
    
    func unlockAchievement(at index: Int) {
        guard index >= 0 && index < achievements.count else { return }
        achievements[index] = true
        // For session-based achievements, save separate keys.
        if index == 3 {
            UserDefaults.standard.set(true, forKey: "achievement_speed_demon")
        } else if index == 4 {
            UserDefaults.standard.set(true, forKey: "achievement_perfect_session")
        }
        saveAchievements()
        print("Unlocked achievement at index \(index). Achievements now: \(achievements)")
    }
    
    private func loadAchievements() {
        if let savedAchievements = UserDefaults.standard.array(forKey: "achievements") as? [Bool] {
            achievements = Array(savedAchievements.prefix(9)) +
                Array(repeating: false, count: max(0, 9 - savedAchievements.count))
        } else {
            print("No saved achievements found, initializing achievements to false.")
            achievements = Array(repeating: false, count: 9)
        }
        
        // Restore session-based achievements.
        if UserDefaults.standard.bool(forKey: "achievement_speed_demon") {
            achievements[3] = true
        }
        if UserDefaults.standard.bool(forKey: "achievement_perfect_session") {
            achievements[4] = true
        }
        // Force coconut achievement if applicable.
        if allTimeCollectedFruits.contains("🥥") {
            achievements[8] = true
            print("Loaded achievements: Coconut Collector forced UNLOCKED because allTimeCollectedFruits contains 🥥")
        }
        print("Loaded achievements: \(achievements)")
    }
    
    func checkAchievements() {
        print("Checking achievements...")
        var newAchievements = achievements
        if newAchievements.count < 9 {
            newAchievements = Array(newAchievements.prefix(9)) +
                Array(repeating: false, count: max(0, 9 - newAchievements.count))
        }
        
        // Champion: Reach 500 points.
        let championUnlocked = totalPoints >= 500
        newAchievements[0] = achievements[0] || championUnlocked
        if championUnlocked && !achievements[0] {
            print("Champion achievement unlocked!")
        }
        
        // First Steps: Complete your first task.
        let firstStepsUnlocked = totalPoints >= 1
        newAchievements[1] = achievements[1] || firstStepsUnlocked
        if firstStepsUnlocked && !achievements[1] {
            print("First Steps achievement unlocked!")
        }
        
        // Memory Master: Reach 100 points.
        let memoryMasterUnlocked = totalPoints >= 100
        newAchievements[2] = achievements[2] || memoryMasterUnlocked
        if memoryMasterUnlocked && !achievements[2] {
            print("Memory Master achievement unlocked!")
        }
        
        // Speed Demon: 10 tasks in session under 60 seconds.
        if let startTime = sessionStartTime, tasksCompletedInSession >= 3 {
            let elapsedTime = Date().timeIntervalSince(startTime)
            let speedDemonCondition = elapsedTime <= 60
            newAchievements[3] = achievements[3] || speedDemonCondition
            if speedDemonCondition && !achievements[3] {
                print("Speed Demon achievement unlocked! Elapsed time: \(elapsedTime) seconds")
                unlockAchievement(at: 3)
            }
        }
        
        // Perfect Session: 10 tasks and zero mistakes.
        let perfectSessionCondition = tasksCompletedInSession >= 3 && currentSessionMistakes == 0
        newAchievements[4] = achievements[4] || perfectSessionCondition
        if perfectSessionCondition && !achievements[4] {
            print("Perfect Session achievement unlocked!")
            unlockAchievement(at: 4)
        }
        
        // Consistent Learner: Use the app daily for a week.
        let consistentLearnerUnlocked = dailyUsageStreak >= 7
        newAchievements[5] = achievements[5] || consistentLearnerUnlocked
        if consistentLearnerUnlocked && !achievements[5] {
            print("Consistent Learner achievement unlocked!")
        }
        
        // Fruit Collector: All fruits collected across sessions.
        let fruitCollectorUnlocked = remainingFruits.isEmpty
        newAchievements[6] = achievements[6] || fruitCollectorUnlocked
        if fruitCollectorUnlocked && !achievements[6] {
            print("Fruit Collector achievement unlocked!")
        } else {
            print("Remaining fruits for Fruit Collector: \(remainingFruits)")
        }
        
        // Grocery Seller: All fruits collected in a single session.
        let allFruits: Set<String> = ["🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍈", "🍅"]
        let grocerySellerUnlocked = fruitsCollectedInSession == allFruits
        newAchievements[7] = achievements[7] || grocerySellerUnlocked
        if grocerySellerUnlocked && !achievements[7] {
            print("Grocery Seller achievement unlocked!")
        } else {
            print("Fruits collected in session: \(fruitsCollectedInSession)")
        }
        
        // Coconut Collector: Obtain a coconut fruit at least once.
        let coconutCollectorUnlocked = allTimeCollectedFruits.contains("🥥")
        newAchievements[8] = achievements[8] || coconutCollectorUnlocked
        if coconutCollectorUnlocked && !achievements[8] {
            print("Coconut Collector achievement unlocked!")
        }
        
        // Update persistent achievements if changed.
        if newAchievements != achievements {
            objectWillChange.send()
            achievements = newAchievements
        }
        
        saveAchievements()
    }

    // MARK: - Fruit Management
    func collectFruit(_ fruit: String) {
        print("Collecting fruit: \(fruit)")
        fruitsCollectedInSession.insert(fruit)
        allTimeCollectedFruits.insert(fruit)
        remainingFruits.remove(fruit)
        print("All-time collected fruits: \(allTimeCollectedFruits)")
        saveAllTimeCollectedFruits()
        checkAchievements()
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
        print("Last usage date: \(lastUsageDate)")
        if !Calendar.current.isDateInToday(lastUsageDate) {
            dailyUsageStreak += 1
            let newDate = Date()
            UserDefaults.standard.set(newDate, forKey: "lastUsageDate")
            print("Incremented dailyUsageStreak to \(dailyUsageStreak), new lastUsageDate: \(newDate)")
        } else {
            print("Already used today, dailyUsageStreak remains \(dailyUsageStreak)")
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
