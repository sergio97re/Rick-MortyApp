//
//  CharactersListView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import SwiftUI

struct CharactersListView: View {
    @State var viewModel: CharactersViewModel
    @State var locationsViewModel: LocationsViewModel
    @State private var characterName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("", text: $characterName, prompt: Text("Buscar personaje...").foregroundStyle(.gray))
                    .foregroundStyle(.mint)
                    .padding([.horizontal, .vertical], 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.mint, lineWidth: 2)
                    }
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .onSubmit {
                        viewModel.getCharacters(name: characterName)
                    }
                
                List {
                    if let characters = viewModel.characters {
                        ForEach(characters) { data in
                            ZStack {
                                NavigationLink(destination: CharacterDetailView(character: data, locationType: locationType(for: data))) { EmptyView() }.opacity(0.0)
                                CharacterRowView(character: data)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }else {
                        ErrorView(error: "Error al cargar datos")
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .navigationBarTitle("Rick & Morty")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: characterName) { oldValue, newValue in
            viewModel.getCharacters(name: newValue)
        }
    }
    
    func locationType(for character: Character) -> String {
        return locationsViewModel.locations?
            .first(where: { $0.name == character.location.name })?
            .type ?? "Planet"
    }
}


#Preview {
    CharactersListView(viewModel: CharactersViewModel(testing: true), locationsViewModel: LocationsViewModel(testing: true))
}
