//
//  MajorAsociationView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 24/01/2025.
//

import SwiftUI

struct MajorAsociationView: View {
    let steps: [GuideStep] = [
        GuideStep(text: LocalizedStringKey("ma_step_0"), imageName: "ma_step_0", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_1"), imageName: "ma_step_1", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_2"), imageName: "ma_step_2", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_3"), imageName: "ma_step_3", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_4"), imageName: "ma_step_4", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_5"), imageName: "ma_step_5", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_6"), imageName: "ma_step_6", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_7"), imageName: "ma_step_7", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_8"), imageName: "ma_step_8", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_9"), imageName: "ma_step_9", isImageOnLeft: false),
    ]
    
    // Configurable border properties
    var borderColor: Color = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(steps) { step in
                    HStack(spacing: 5) {
                        if step.isImageOnLeft {
                            styledImage(name: step.imageName)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            styledImage(name: step.imageName)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("ma_title"))
    }
    
    // Helper function to style images
    @ViewBuilder
    private func styledImage(name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            //.background(Color.clear) // Add a background color if needed
            .background(Color.green)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
    
}
