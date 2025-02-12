//
//  TutorialSetpOne.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 12/02/2025.
//
import SwiftUI

struct TutorialSetpOne: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var navigateToTask: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Step 1: Learn how to use the app")
                .font(.title)
                .padding()

            // Start Task Button - Now Visible!
            Button(action: {
                navigateToTask = true
            }) {
                Text("Go to Task")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }

            // Hidden navigation to TaskView
            NavigationLink(
                destination: TaskView(
                    currentWord: wordStore.getRandomWord(),
                    isCheatSheetEnabled: wordStore.isCheatSheetEnabled,
                    isRandomizeDiceEnabled: wordStore.isRandomizeDiceEnabled,
                    wordStore: wordStore
                )
                .onAppear {
                    print("TaskView appeared!")
                }
                .onDisappear {
                    print("TaskView disappeared! Returning to FirstManualView")
                }
                .navigationBarBackButtonHidden(true),
                isActive: $navigateToTask
            ) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
    }
}
