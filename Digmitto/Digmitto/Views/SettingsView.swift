import SwiftUI

struct SettingsView: View {
    @State private var assignments: [Int: String] = [
        0: "s, z", 1: "t, d", 2: "n", 3: "m", 4: "r",
        5: "l", 6: "j, sz, cz", 7: "k, g", 8: "f, w", 9: "p, b"
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Letter-to-Digit Assignments")) {
                ForEach(assignments.keys.sorted(), id: \.self) { key in
                    HStack {
                        Text("Digit \(key)")
                        TextField("Letters", text: Binding(
                            get: { self.assignments[key] ?? "" },
                            set: { self.assignments[key] = $0 }
                        ))
                    }
                }
            }
            Button("Reset to Default") {
                // Reset logic
                assignments = [
                    0: "s, z", 1: "t, d", 2: "n", 3: "m", 4: "r",
                    5: "l", 6: "j, sz, cz", 7: "k, g", 8: "f, w", 9: "p, b"
                ]
            }
        }
    }
} 