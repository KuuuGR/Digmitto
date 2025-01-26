//
//  PointsAndFruitsView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct PointsAndFruitsView: View {
    let points: Int
    let fruitEmojis: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(String(format: NSLocalizedString("tv_points", comment: ""), points))
                .font(.title2)
                .padding(.bottom, 4)
            Text(String(format: NSLocalizedString("tv_fruits", comment: ""), fruitEmojis.joined(separator: " ")))
                .font(.title2)
        }
        .padding(.leading, 20)
    }
}

