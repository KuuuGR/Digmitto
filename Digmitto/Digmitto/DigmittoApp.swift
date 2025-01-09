//
//  DigmittoApp.swift
//  Digmitto
//
//  Created by Grzegorz Kulesza on 07/01/2025.
//

import SwiftUI

@main
struct DigmittoApp: App {
    @StateObject private var wordStore = WordStore()
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environmentObject(wordStore)
        }
    }
}
