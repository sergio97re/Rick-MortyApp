//
//  EpisodeDetailView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    let characters: [CharacterBasic]
    
    @State var viewModel: EpisodesViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AnimatedGradientBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text(episode.name)
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .shadow(radius: 5)

                        Text(episode.episode)
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.8))

                        Text(episode.airDate)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .padding(.top, 50)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Personajes")
                            .font(.title2.bold())
                            .foregroundStyle(.white)

                        ForEach(characters) { character in
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                        .opacity(0.6)
                                }

                                VStack(alignment: .leading) {
                                    Text(character.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)

                                    Text("\(character.species) - \(character.status)")
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.8))
                                }

                                Spacer()

                                if character.gender == "Male" {
                                    Image("male")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                } else {
                                    Image("female")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                    .shadow(radius: 10)
                }
                .padding(.bottom, 40)
            }

            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func characterName(from url: String) -> String {
        if let id = url.split(separator: "/").last {
            return "Character #\(id)"
        }
        return "Unknown"
    }
}


#Preview {
    EpisodeDetailView(
        episode: Episode(
            id: 1,
            name: "Pilot",
            airDate: "December 2, 2013",
            episode: "S01E01",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2"
            ],
            url: "https://rickandmortyapi.com/api/episode/1",
            created: "2017-11-10T12:56:33.798Z"
        ), characters: [
            CharacterBasic(id: 1, name: "Rick Sanchez", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", species: "Human", status: "Alive"),
            CharacterBasic(id: 2, name: "Morty Smith", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: "Male", species: "Human", status: "Alive")
        ], viewModel: EpisodesViewModel(testing: true)
    )
}

