import SwiftUI

struct DeveloperView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Developer Info")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Group {
                    Text("About Developer")
                        .font(.headline)
                    Text("Created by [Your Name]")
                    Text("Contact: [Your Email/Contact Info]")
                    
                    Text("Future Updates")
                        .font(.headline)
                        .padding(.top)
                    Text("Planned features:")
                    Text("• Multiple language support")
                    Text("• Custom word lists")
                    Text("• Progress tracking")
                    Text("• Advanced practice modes")
                    Text("• Cloud synchronization")
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Developer")
    }
} 