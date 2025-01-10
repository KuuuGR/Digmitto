import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var wordStore: WordStore
    @Binding var isCheatSheetVisible: Bool
    @State private var temporaryMajorLetters: String = ""
    
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
                .onChange(of: wordStore.enableColorization) { isEnabled in
                    if isEnabled {
                        // Ensure secondary color is not overwritten by default color
                        wordStore.secondaryColor = wordStore.defaultColor
                    }
                }
            
            if wordStore.enableColorization {
                ColorPicker("Primary Color", selection: $wordStore.primaryColor)
                ColorPicker("Secondary Color", selection: $wordStore.secondaryColor)
                
                Text("Major Letters")
                    .font(.headline)
                TextField("Enter letters", text: $temporaryMajorLetters, onCommit: {
                    updateMajorSystemLetters()
                })
                .onAppear {
                    temporaryMajorLetters = wordStore.majorSystemLetters
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
            } else {
                ColorPicker("Default Color", selection: $wordStore.defaultColor)
            }
        }
        .navigationBarTitle("Settings")
    }
    
    private func updateMajorSystemLetters() {
        let processedLetters = Set(temporaryMajorLetters.lowercased()).sorted()
        wordStore.majorSystemLetters = String(processedLetters)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isCheatSheetVisible: .constant(true))
            .environmentObject(WordStore())
    }
} 
