//
//  ContentView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var words = ["motor", "table", "lamp"] // Example words
    @State private var currentWord = "motor" // Initialize currentWord

    var body: some View {
        NavigationView {
            VStack {
                Text("Digmitto")
                    .font(.largeTitle)
                    .padding(.top)
                Spacer()
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                NavigationLink(destination: TaskView(currentWord: currentWord)) {
                    Text("Start")
                        .font(.title)
                        .padding()
                }
                Spacer()
                Text("ver. 0.0.1")
                    .font(.footnote)
                    .padding(.bottom)
            }
            .onAppear {
                currentWord = words.randomElement() ?? "motor"
            }
        }
    }
}

#Preview {
    ContentView()
}
