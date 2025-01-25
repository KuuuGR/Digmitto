import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var temporaryMajorLetters: String = ""
    
    var body: some View {
        Form {
            // General Settings Section
            Section(header: Text(LocalizedStringKey("sv_general_settings"))) {
                Toggle(isOn: $wordStore.isCheatSheetEnabled) {
                    Text(LocalizedStringKey("sv_enable_cheat_sheet"))
                }
                
                Picker(LocalizedStringKey("sv_language"), selection: $wordStore.selectedLanguage) {
                    ForEach(["English", "Polish", "Spanish"], id: \.self) { language in
                        Text(getLocalizedLanguageName(language)).tag(language)
                    }
                }
            } // <-- Properly closing General Settings Section
            
            // Colorization Settings Section
            Section(header: Text(LocalizedStringKey("sv_colorization_settings"))) {
                Toggle(LocalizedStringKey("sv_enable_colorization"), isOn: $wordStore.enableColorization)
                
                if wordStore.enableColorization {
                    ColorPicker(LocalizedStringKey("sv_primary_color"), selection: $wordStore.primaryColor)
                    ColorPicker(LocalizedStringKey("sv_secondary_color"), selection: $wordStore.secondaryColor)
                }
            }
            
            // Default Color Section
            if !wordStore.enableColorization {
                Section(header: Text(LocalizedStringKey("sv_default_color_settings"))) {
                    ColorPicker(LocalizedStringKey("sv_default_color"), selection: $wordStore.defaultColor)
                }
            }
            
            // Major System Letters Section
            Section(header: Text(LocalizedStringKey("sv_major_system_letters"))) {
                Text(LocalizedStringKey("sv_major_letters"))
                    .font(.headline)
                TextField(LocalizedStringKey("sv_enter_letters"), text: $temporaryMajorLetters, onCommit: {
                    updateMajorSystemLetters()
                })
                .onAppear {
                    temporaryMajorLetters = wordStore.majorSystemLetters
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
            
            // Additional Settings Section
            Section(header: Text(LocalizedStringKey("sv_additional_settings"))) {
                Toggle(isOn: $wordStore.isRandomizeDiceEnabled) {
                    Text(LocalizedStringKey("sv_enable_randomizing_dice"))
                }
                
            } // <-- Properly closing Additional Settings Section
        }
        .navigationBarTitle(LocalizedStringKey("sv_settings_title"))
    }
    
    private func updateMajorSystemLetters() {
        let processedLetters = Set(temporaryMajorLetters.lowercased()).sorted()
        wordStore.majorSystemLetters = String(processedLetters)
    }
        
    private func getLocalizedLanguageName(_ language: String) -> LocalizedStringKey {
        switch language.lowercased() {
        case "english":
            return LocalizedStringKey("sv_language_english")
        case "polish":
            return LocalizedStringKey("sv_language_polish")
        case "spanish":
            return LocalizedStringKey("sv_language_spanish")
        default:
            return LocalizedStringKey(language) // Fallback to original name if not localized
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .environmentObject(WordStore())
//    }
//}
