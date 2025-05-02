//
//  CharacterDetailView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 15/04/2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    let locationType: String
    @State private var selectedLocation: LocationDetail?
    @State private var isNavigatingToLocation = false

    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(backgroundImageName(for: locationType))
                    .resizable()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
                
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 6)
                                .shadow(color: .yellow, radius: 10)
                        )
                        .padding(.top, 100)
                        
                        VStack {
                            // Info principal
                            VStack(alignment: .leading, spacing: 16) {
                                Text(character.name)
                                    .font(.title.bold())
                                    .foregroundStyle(.yellow)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    InfoRow(title: "Status", value: character.status)
                                    InfoRow(title: "Species", value: character.species)
                                    InfoRow(title: "Gender", value: character.gender)
                                    InfoRow(title: "Origin", value: character.origin.name)
                                    Button {
                                        Task {
                                            await fetchLocationDetail(from: character.location.url)
                                        }
                                    } label: {
                                        InfoRow(title: "Location", value: character.location.name)
                                    }
                                    
                                }
                                .padding()
                                .frame(width: 350, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                )
                            }
                            .padding()
                            .cornerRadius(20)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrowtriangle.left")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                .navigationDestination(isPresented: $isNavigatingToLocation) {
                    if let location = selectedLocation {
                        LocationDetailView(location: location)
                    }
                }
            }
        }
    }
    
    private func fetchLocationDetail(from urlString: String) async {
        guard let url = URL(string: urlString) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let location = try JSONDecoder().decode(LocationDetail.self, from: data)
            selectedLocation = location
            isNavigatingToLocation = true
        } catch {
            print("Error al cargar location:", error)
        }
    }

}

func backgroundImageName(for locationType: String) -> String {
    switch locationType.lowercased() {
    case "planet":
        return "planet"
    case "cluster":
        return "cluster"
    case "space station":
        return "spacestation"
    case "tv":
        return "tv"
    case "resort":
        return "resort"
    case "fantasy town":
        return "fantasytown"
    case "dream":
        return "dream"
    case "microverse":
        return "microverse"
    default:
        return "planet"
    }
}

// MARK: - Info Row View
struct InfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(.title3)
                .foregroundStyle(.white)
            Text(value)
                .font(.headline)
                .bold()
                .foregroundStyle(.white)
                .padding(8)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
        }
    }
}


#Preview {
    CharacterDetailView(character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
        location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2"
        ],
        url: "https://rickandmortyapi.com/api/character/1"
    ), locationType: "Citadel of Ricks")
}
