//
//  HomeView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(RootViewModel.self) private var rootViewModel
    
    var body: some View {
        VStack {
            CharactersListView(viewModel: CharactersViewModel(), locationsViewModel: LocationsViewModel(testing: true))
        }
        .tabItem {
            Image(systemName: "house")
            Text("Home")
        }
    }
}

#Preview {
    HomeView()
        .environment(RootViewModel())
}
