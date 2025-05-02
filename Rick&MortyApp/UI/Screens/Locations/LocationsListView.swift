//
//  LocationsListView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 21/04/2025.
//

import SwiftUI

struct LocationsListView: View {
    @State var viewModel: LocationsViewModel
    @State private var locationName: String = ""
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("", text: $locationName, prompt: Text("Buscar lugar...").foregroundStyle(.gray))
                    .foregroundStyle(.mint)
                    .padding([.horizontal, .vertical], 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.mint, lineWidth: 2)
                    }
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .onSubmit {
                        viewModel.getLocations(name: locationName)
                    }
                
                ScrollView {
                    if let locations = viewModel.locations {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(locations) { data in
                                NavigationLink(destination: LocationDetailView(location: data)) {
                                    LocationsRowView(location: data)
                                }
                            }
                        }
                    }else {
                        ErrorView(error: "Error al cargar datos")
                    }
                }
                .padding()
                .navigationBarTitle("Locations")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: locationName) { oldValue, newValue in
            viewModel.getLocations(name: newValue)
        }
    }
}

#Preview {
    LocationsListView(viewModel: LocationsViewModel(testing: true))
}
