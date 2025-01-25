//
//  MajorAsociationView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 24/01/2025.
//

import SwiftUI

struct MajorAsociationView: View {
    let steps: [GuideStep] = [
        GuideStep(text: LocalizedStringKey("tut_step_0"), imageName: "tut_step_0", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_1"), imageName: "tut_step_1", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_2"), imageName: "tut_step_2", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_3"), imageName: "tut_step_3", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_4"), imageName: "tut_step_4", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_5"), imageName: "tut_step_5", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_6"), imageName: "tut_step_6", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_7"), imageName: "tut_step_7", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_8"), imageName: "tut_step_8", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_9"), imageName: "tut_step_9", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_10"), imageName: "tut_step_10", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_11"), imageName: "tut_step_11", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_12"), imageName: "tut_step_12", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_13"), imageName: "tut_step_13", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_14"), imageName: "tut_step_14", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_15"), imageName: "tut_step_15", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("tut_step_16"), imageName: "tut_step_16", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("tut_step_17"), imageName: "tut_step_17", isImageOnLeft: false),
    ]
    
    // Configurable border properties
    var borderColor: Color = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(steps) { step in
                    HStack(spacing: 20) {
                        if step.isImageOnLeft {
                            styledImage(name: step.imageName)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            styledImage(name: step.imageName)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("guide_title"))
    }
    
    // Helper function to style images
    @ViewBuilder
    private func styledImage(name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .background(Color.clear) // Add a background color if needed
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
    
}
