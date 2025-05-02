//
//  Rick_MortyAppApp.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 24/03/2025.
//

import SwiftUI

@main
struct Rick_MortyAppApp: App {
    @State var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(rootViewModel)
        }
    }
}
