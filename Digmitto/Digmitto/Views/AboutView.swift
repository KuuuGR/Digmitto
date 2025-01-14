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
                        .font(.body)
                    
                    Text("How it works:")
                        .font(.headline)
                    Text("• Each digit is assigned to specific consonant sounds")
                        .font(.body)
                    Text("• Vowels and unused consonants can be added freely")
                        .font(.body)
                    Text("• Create words using these sounds to remember numbers")
                        .font(.body)
                    
                    Text("Examples:")
                        .font(.headline)
                    Text("123 → \"TuNeMo\"")
                        .font(.body)
                    Text("507 → \"LaSeKa\"")
                        .font(.body)
                    Text("999 → \"PaPaPa\"")
                        .font(.body)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
} 