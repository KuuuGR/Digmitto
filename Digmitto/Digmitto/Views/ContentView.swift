//
//  ContentView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var words = ["motor", "table", "lamp"]
    @State private var currentWord = "motor"
    @State private var isCheatSheetVisible = false // Control sheet visibility

    var body: some View {
        NavigationView {
            VStack {
                Text(LocalizedStringKey("welcome_message"))
                    .font(.largeTitle)
                    .padding()

                Spacer()

                NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: isCheatSheetVisible)) {
                    Text(LocalizedStringKey("start_button"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    isCheatSheetVisible.toggle()
                }) {
                    Text("Show Cheat Sheet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: SettingsView(isCheatSheetVisible: $isCheatSheetVisible)) {
                    Text(LocalizedStringKey("settings_title"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .onAppear {
                currentWord = words.randomElement() ?? "motor"
            }
            .sheet(isPresented: $isCheatSheetVisible) {
                CheatSheetView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
