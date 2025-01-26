//
//  NumberWheel.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct NumberWheel: View {
    @Binding var selectedNumber: Int
    let gradient: LinearGradient // Gradient instead of Color

    var body: some View {
        Picker(selection: $selectedNumber, label: Text("")) {
            ForEach(0..<10) { number in
                Text("\(number)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 60, height: 150)
        .background(gradient) // Apply the gradient here
        .cornerRadius(10)
        .clipped()
    }
}
