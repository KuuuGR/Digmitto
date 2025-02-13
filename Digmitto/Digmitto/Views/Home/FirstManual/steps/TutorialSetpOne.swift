//
//  TutorialSetpOne.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 12/02/2025.
//
import SwiftUI

struct TutorialSetpOne: View {
    @StateObject var wordStore = WordStore()
    @State private var currentWord: String = ""
    @State private var navTrigger = false
    
    var body: some View {
        VStack(spacing: 5) {
            // General Action Text
            Text(LocalizedStringKey("tso_general"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 1)
                .foregroundColor(.purple.opacity(0.7))
                .padding(.bottom, 20)
            
            // Instructions Section
            VStack(alignment: .leading, spacing: 10) {
                Text(LocalizedStringKey(""))
                Text(LocalizedStringKey("tso_how_to_start_title"))
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(LocalizedStringKey("tso_instruction_step1"))
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("tso_instruction_bullet1"))
                    Text(LocalizedStringKey("tso_instruction_bullet2"))
                }
                .font(.callout)
                .foregroundColor(.gray)
                
                Text(LocalizedStringKey("tso_instruction_step2"))
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey("tso_instruction_bullet3"))
                    Text(LocalizedStringKey("tso_instruction_bullet4"))
                    Text(LocalizedStringKey("tso_instruction_bullet5"))
                    Text(LocalizedStringKey("tso_instruction_bullet6"))
                    Text(LocalizedStringKey(""))
                }
                .font(.callout)
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            // Start Task Button
            NavigationLink(
                destination: TaskView(
                    currentWord: NSLocalizedString("tso_word_for_practice", comment: ""),
                    isCheatSheetEnabled: true,
                    isRandomizeDiceEnabled: false,
                    wordStore: wordStore, comebackAfterOneWord: true
                )
                .environmentObject(wordStore),
                isActive: $navTrigger
            ) {
                PastelButton(
                    title: LocalizedStringKey("tso_start_task"),
                    colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]
                )
            }
            .padding(.horizontal, 40)
            .simultaneousGesture(TapGesture().onEnded {
                if currentWord.isEmpty || currentWord == "No word" {
                    currentWord = wordStore.getRandomWord()
                }
                print("TutorialSetpOne: currentWord before Navigation = \(currentWord)")
                navTrigger = true
            })
    
            Spacer()
        }
        .padding()
        .onAppear {
            print("TutorialSetpOne appeared! Current word: \(currentWord)")
        }
        .onDisappear {
            print("TutorialSetpOne disappeared unexpectedly! Current word: \(currentWord)")
        }
    }
}
