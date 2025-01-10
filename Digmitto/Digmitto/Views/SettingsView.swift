import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var wordStore: WordStore
    @Binding var isCheatSheetVisible: Bool
    
    var body: some View {
        Form {
            Toggle(isOn: $isCheatSheetVisible) {
                Text("Enable Cheat Sheet")
            }
            
            Picker("Language", selection: $wordStore.selectedLanguage) {
                ForEach(["English", "Polish", "Spanish"], id: \.self) { language in
                    Text(language).tag(language)
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isCheatSheetVisible: .constant(true))
            .environmentObject(WordStore())
    }
} 
