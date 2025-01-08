import SwiftUI

struct SettingsView: View {
    @State private var isColoringEnabled = true
    @State private var isCheatSheetVisible = true
    @State private var selectedLanguage = "English"

    var body: some View {
        Form {
            Section(header: Text("Display Options")) {
                Toggle("Enable Letter Coloring", isOn: $isColoringEnabled)
                Toggle("Show Cheat Sheet", isOn: $isCheatSheetVisible)
            }

            Section(header: Text("Language")) {
                Picker("Select Language", selection: $selectedLanguage) {
                    Text("Polish").tag("Polish")
                    Text("English").tag("English")
                    Text("Spanish").tag("Spanish")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
} 