//
//  Manuals.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 24/01/2025.
//

import SwiftUI

struct ManualsView: View {
    var body: some View {
        VStack(spacing: 5) {
            Text(LocalizedStringKey("mn_general"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 1)
                //.foregroundColor(.purple.opacity(0.7))
                .foregroundColor(Color.pastelBlue.opacity(0.6))
                .padding(.bottom, 5)
            
            Spacer()
        
            // Start Task Button
            NavigationLink(destination: MajorAsociationView()) {
                PastelButton(
                    title: LocalizedStringKey("mn_major_numbers"),
                    colors: [Color.softMauve.opacity(0.6), Color.paleLavender.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            // View Points Button
            NavigationLink(destination: GuideWalkthroughView()) {
                PastelButton(
                    title: LocalizedStringKey("mn_app_manual"),
                    colors: [Color.softBlue.opacity(0.6), Color.skyBlue.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            // Manual Button
            NavigationLink(destination: MajorMnemoView()) {
                PastelButton(
                    title: LocalizedStringKey("mn_numbers_mnemotechnics"),
                    colors: [Color.lightBlue.opacity(0.6), Color.paleLavender.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}
