//
//  MainTabView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 21/04/2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(RootViewModel.self) private var rootViewModel
    
    var body: some View {
        NavigationStack {
            TabView {
                Group{
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    LocationsView()
                        .tabItem {
                            Image(systemName: "map")
                            Text("Locations")
                        }
                }
                .toolbarBackground(Color.mint.opacity(0.4), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .accentColor(.pink)
        }
    }
}

#Preview {
    MainTabView()
        .environment(RootViewModel())
}
