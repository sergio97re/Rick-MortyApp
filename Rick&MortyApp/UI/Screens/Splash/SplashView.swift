//
//  SplashView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 01/04/2025.
//

import SwiftUI

struct SplashView: View {
    @Environment(RootViewModel.self) private var rootViewModel

    var body: some View {
        ZStack {
            Image("rick-morty-splash")
                .resizable()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                .scaleEffect(1.5)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    rootViewModel.status = .home
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environment(RootViewModel())
}
