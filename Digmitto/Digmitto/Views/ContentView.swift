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
            ZStack {
                VStack {
                    Spacer() // Pushes content to center
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 50) // Adds space between the image and the button

                    NavigationLink(destination: TaskView(currentWord: currentWord)) {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .onTapGesture {
                        print("Start button tapped")
                    }
                    .padding()
                    Spacer() // Ensures the button is centered vertically
                }
                .navigationTitle("")

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("ver. 0.0.1")
                            .font(.footnote)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            currentWord = words.randomElement() ?? "motor"
            print("Navigated to TaskView with word: \(currentWord)")
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensure correct navigation style
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
