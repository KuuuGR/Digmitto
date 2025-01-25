//
//  MajorAsociationView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 24/01/2025.
//

import SwiftUI

struct MajorAsociationView: View {
    let steps: [GuideStep] = [
        GuideStep(text: LocalizedStringKey("ma_step_0"), imageName: "ArrowR", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_1"), imageName: "ArrowL", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_2"), imageName: "ArrowR", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_3"), imageName: "ArrowL", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_4"), imageName: "ArrowR", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_5"), imageName: "ArrowL", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_6"), imageName: "ArrowR", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_7"), imageName: "ArrowL", isImageOnLeft: false),
        GuideStep(text: LocalizedStringKey("ma_step_8"), imageName: "ArrowR", isImageOnLeft: true),
        GuideStep(text: LocalizedStringKey("ma_step_9"), imageName: "ArrowL", isImageOnLeft: false),
    ]
    
    // Configurable border properties
    var borderColor: Color = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 30

    // Color array for backgrounds
    let backgroundColors: [Color] = [
        Color.red.opacity(0.6),
        Color.orange.opacity(0.6),
        Color.yellow.opacity(0.6),
        Color.blue.opacity(0.6),
        Color.green.opacity(0.6),
        Color.purple.opacity(0.6),
        Color.brown.opacity(0.6),
        Color.cyan.opacity(0.6),
        Color.indigo.opacity(0.6),
        Color.mint.opacity(0.6),
        Color.pastelGreen.opacity(0.6),
        Color.paleLavender.opacity(0.6),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 1) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    HStack(spacing: 10) {
                        if step.isImageOnLeft {
                            styledImage(name: step.imageName, index: index)
                                .scaledToFit()
                                .frame(width: 20, height: 20) // Adjust size if needed
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            styledImage(name: step.imageName, index: index)
                                .scaledToFit()
                                .frame(width: 20, height: 20) // Adjust size if needed
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
    private func styledImage(name: String, index: Int) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .background(backgroundColors[index % backgroundColors.count]) // Use colors cyclically
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}
