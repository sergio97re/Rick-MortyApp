//
//  AnimatedGradientBackground.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var animate = false

    var body: some View {
        LinearGradient(
            colors: [.purple, .blue, .indigo, .pink],
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
        .animation(
            .easeInOut(duration: 6).repeatForever(autoreverses: true),
            value: animate
        )
        .onAppear {
            animate = true
        }
    }
}


#Preview {
    AnimatedGradientBackground()
}
