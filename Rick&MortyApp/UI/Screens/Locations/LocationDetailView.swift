//
//  LocationDetailView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 30/04/2025.
//

import SwiftUI

struct LocationDetailView: View {
    let location: LocationDetail
    @State private var residents: [Character] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(backgroundImageName(for: location.type))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(RoundedCorner(radius: 30, corners: .bottomLeft))
                
                Text(location.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.mint)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Type: \(location.type)")
                        .font(.headline)
                        .foregroundStyle(.pink)
                    
                    Text("Dimension: \(location.dimension)")
                        .font(.headline)
                        .foregroundStyle(.pink)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.mint, lineWidth: 1)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(residents) { character in
                            VStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                
                                Text(character.name)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 80)
                            }
                        }
                    }
                    .padding([.horizontal, .vertical])
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
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
        .onAppear {
            Task {
                await fetchResidents()
            }
        }
    }
    
    private func fetchResidents() async {
        let ids = location.residents.compactMap { URL(string: $0)?.lastPathComponent }.joined(separator: ",")
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(ids)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if location.residents.count == 1 {
                if let single = try? JSONDecoder().decode(Character.self, from: data) {
                    self.residents = [single]
                }
            } else {
                let result = try JSONDecoder().decode([Character].self, from: data)
                self.residents = result
            }
        } catch {
            print("Error al cargar residents:", error)
        }
    }
}


#Preview {
    LocationDetailView(
        location: LocationDetail(
            id: 1,
            name: "Earth (C-137)",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2"
            ],
            url: "https://rickandmortyapi.com/api/location/1",
            created: "2017-11-10T12:42:04.162Z"
        )
    )
}

