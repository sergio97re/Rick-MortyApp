//
//  LocationsRowView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 21/04/2025.
//

import SwiftUI

struct LocationsRowView: View {
    let location: LocationDetail
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(backgroundImageName(for: location.type))
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
                .overlay(Color.black.opacity(0.4))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.yellow)
                    .lineLimit(1)
                Text(location.type)
                    .font(.title3)
                    .foregroundStyle(.white)
                Text("\(location.residents.count) habitantes")
                    .font(.callout)
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.2))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    LocationsRowView(location: LocationDetail(
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
    ))
}
