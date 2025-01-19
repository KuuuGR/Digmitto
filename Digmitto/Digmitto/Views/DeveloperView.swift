import SwiftUI

struct DeveloperView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Developer Info Title
                Text(LocalizedStringKey("dv_developer_info"))
                    .font(.title)
                    .padding(.bottom, 10)
                
                // About Developer Section
                Group {
                    Text(LocalizedStringKey("dv_about_developer"))
                        .font(.headline)
                    Text(LocalizedStringKey("dv_created_by"))
                    Text(LocalizedStringKey("dv_contact_info"))
                    
                    // Future Updates Section
                    Text(LocalizedStringKey("dv_future_updates"))
                        .font(.headline)
                        .padding(.top)
                    Text(LocalizedStringKey("dv_planned_features"))
                    Text(LocalizedStringKey("dv_feature_multilanguage"))
                    Text(LocalizedStringKey("dv_feature_wordlists"))
                    Text(LocalizedStringKey("dv_feature_progress_tracking"))
                    Text(LocalizedStringKey("dv_feature_practice_modes"))
                    Text(LocalizedStringKey("dv_feature_cloud_sync"))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("dv_navigation_title"))
    }
}
