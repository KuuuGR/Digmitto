import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var wordStore: WordStore
    @Binding var isCheatSheetVisible: Bool
    @State private var temporaryMajorLetters: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("General Settings")) {
                Toggle(isOn: $isCheatSheetVisible) {
                    Text("Enable Cheat Sheet")
                }
                
                Picker("Language", selection: $wordStore.selectedLanguage) {
                    ForEach(["English", "Polish", "Spanish"], id: \.self) { language in
                        Text(language).tag(language)
                    }
                }
            }
            
            Section(header: Text("Colorization Settings")) {
                Toggle("Enable Colorization", isOn: $wordStore.enableColorization)
                
                if wordStore.enableColorization {
                    ColorPicker("Primary Color", selection: $wordStore.primaryColor)
                    ColorPicker("Secondary Color", selection: $wordStore.secondaryColor)
                }
            }
            
            Section(header: Text("Default Color Setting")) {
                if !wordStore.enableColorization {
                    ColorPicker("Default Color", selection: $wordStore.defaultColor)
                }
            }
            
            Section(header: Text("Major System Letters")) {
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
