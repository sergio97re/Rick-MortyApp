//
//  RootView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 24/03/2025.
//

import SwiftUI

struct RootView: View {
    @Environment(RootViewModel.self) private var rootViewModel
    
    var body: some View {
        //ViewRouter
        switch rootViewModel.status {
        case .splash:
            SplashView()
        case .loading:
            withAnimation {
                LoaderView()
            }
        case .error(error: let errorString):
            withAnimation {
                ErrorView(error: errorString)
            }
        case .home:
            withAnimation {
                MainTabView()
            }
        }
    }
}

#Preview {
    RootView()
        .environment(RootViewModel())
}
