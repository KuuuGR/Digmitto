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
            
            Toggle("Enable Colorization", isOn: $wordStore.enableColorization)
            
            ColorPicker("Primary Color", selection: $wordStore.primaryColor)
            ColorPicker("Secondary Color", selection: $wordStore.secondaryColor)
            ColorPicker("Default Color", selection: $wordStore.defaultColor)
            
            TextField("Major System Letters", text: $wordStore.majorSystemLetters)
                .autocapitalization(.allCharacters)
                .disableAutocorrection(true)
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
