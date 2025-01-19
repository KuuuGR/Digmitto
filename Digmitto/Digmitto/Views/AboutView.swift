import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(LocalizedStringKey("ab_title"))
                    .font(.title)
                    .padding(.bottom, 10)
                
                Group {
                    Text(LocalizedStringKey("ab_what_is"))
                        .font(.headline)
                    Text(LocalizedStringKey("ab_what_is_description"))
                        .font(.body)
                    
                    Text(LocalizedStringKey("ab_how_it_works"))
                        .font(.headline)
                    Text(LocalizedStringKey("ab_how_it_works_bullet1"))
                        .font(.body)
                    Text(LocalizedStringKey("ab_how_it_works_bullet2"))
                        .font(.body)
                    Text(LocalizedStringKey("ab_how_it_works_bullet3"))
                        .font(.body)
                    
                    Text(LocalizedStringKey("ab_examples"))
                        .font(.headline)
                    Text(LocalizedStringKey("ab_example1"))
                        .font(.body)
                    Text(LocalizedStringKey("ab_example2"))
                        .font(.body)
                    Text(LocalizedStringKey("ab_example3"))
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Developer Button
                NavigationLink(destination: DeveloperView()) {
                    Text(LocalizedStringKey("ab_developer_info"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("ab_title"))
    }
}
