//
//  CharacterRowView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import SwiftUI

struct CharacterRowView: View {
    var character: Character
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundStyle(.gray)
                        .opacity(0.4)
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(character.name)
                        .font(.title3.bold())
                        .foregroundStyle(.mint)
                    
                    Text("\(character.species) • \(character.status)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 6) {
                        Image(systemName: character.gender == "Male" ? "person.fill.viewfinder" : "person.fill.viewfinder")
                            .foregroundStyle(character.gender == "Male" ? .cyan : .pink)
                        Text(character.gender)
                            .font(.caption)
                            .foregroundStyle(character.gender == "Male" ? .cyan : .pink)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


#Preview {
    CharacterRowView(character: Character(
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
    ))
}
