import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About Major System")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Group {
                    Text("What is the Major System?")
                        .font(.headline)
                    Text("The Major System is a mnemonic technique that helps you remember numbers by converting them into consonant sounds, which can then be made into words.")
                    
                    Text("How it works:")
                        .font(.headline)
                    Text("• Each digit is assigned to specific consonant sounds")
                    Text("• Vowels and unused consonants can be added freely")
                    Text("• Create words using these sounds to remember numbers")
                    
                    Text("Examples:")
                        .font(.headline)
                    Text("123 → \"TuNeMo\"")
                    Text("507 → \"LaSeKa\"")
                    Text("999 → \"PaPaPa\"")
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
} 