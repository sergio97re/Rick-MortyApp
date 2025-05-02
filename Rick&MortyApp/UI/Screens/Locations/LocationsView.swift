//
//  LocationsView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 21/04/2025.
//

import SwiftUI

struct LocationsView: View {
    
    var body: some View {
        VStack {
            LocationsListView(viewModel: LocationsViewModel())
        }
        .tabItem {
            Image(systemName: "location")
            Text("Locations")
        }
    }
}

#Preview {
    LocationsView()
}
