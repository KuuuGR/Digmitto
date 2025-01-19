//
//  ContentView.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var currentWord = ""
    @State private var isCheatSheetVisible = false

    var body: some View {
        NavigationView {
            VStack {
                Text(LocalizedStringKey("welcome_message"))
                    .font(.largeTitle)
                    .padding()

                Spacer()

                NavigationLink(destination: TaskView(currentWord: currentWord, isCheatSheetEnabled: isCheatSheetVisible, wordStore: wordStore)) {
                    Text(LocalizedStringKey("start_button"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 100, minHeight: 44)
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
                        .frame(minWidth: 100, minHeight: 44)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .onAppear {
                currentWord = wordStore.getRandomWord()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(WordStore())
//    }
//}
