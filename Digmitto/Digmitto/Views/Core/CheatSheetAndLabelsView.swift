//
//  CheatSheetAndLabelsView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 26/01/2025.
//

import SwiftUI

struct CheatSheetAndLabelsView: View {
    let points: Int
    let fruitEmojis: [String]
    let geometry: GeometryProxy

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            PointsAndFruitsView(points: points, fruitEmojis: fruitEmojis)
                .frame(width: geometry.size.width * 0.6, alignment: .leading)
                .padding(.leading, 20)

            CheatSheetView()
                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.2)
                .background(
                    Image("parchmentBackground")
                        .resizable()
                        .scaledToFill()
                )
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.6), radius: 10, x: -5, y: 5)
                .padding([.trailing, .bottom], 20)
        }
    }
}
