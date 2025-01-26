//
//  NumberWheel.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct NumberWheel: View {
    @Binding var selectedNumber: Int
    let color: Color

    var body: some View {
        Picker(selection: $selectedNumber, label: Text("")) {
            ForEach(0..<10) { number in
                Text("\(number)")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 60, height: 150) // Adjust width and height for the wheel
        .background(color)
        .cornerRadius(10)
        .clipped()
    }
}

