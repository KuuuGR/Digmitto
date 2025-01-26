//
//  DiceButtonView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct DiceButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "die.face.6.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(10)
                .background(Color.yellow.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .frame(width: 60, height: 60)
        .padding(.bottom, 5)
        .opacity(0.8)
    }
}
