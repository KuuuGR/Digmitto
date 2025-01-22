import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section(header: Text(LocalizedStringKey("ab_section_about_app"))) {
                Text(LocalizedStringKey("ab_app_name"))
                Text(LocalizedStringKey("ab_version"))
                Text(LocalizedStringKey("ab_developer"))
            }
            
            Section(header: Text(LocalizedStringKey("ab_section_purpose"))) {
                Text(LocalizedStringKey("ab_purpose_major_system"))
                Text(LocalizedStringKey("ab_purpose_large_numbers"))
                Text(LocalizedStringKey("ab_purpose_dates"))
                Text(LocalizedStringKey("ab_purpose_words"))
            }
            
            Section(header: Text(LocalizedStringKey("ab_section_support"))) {
                NavigationLink(destination: SupportDeveloperView()) {
                    Text(LocalizedStringKey("ab_support_developer"))
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(LocalizedStringKey("ab_navigation_title"))
    }
}
