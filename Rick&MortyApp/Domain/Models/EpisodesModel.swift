//
//  EpisodesModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import Foundation

// MARK: - EpisodeResponse
struct EpisodeResponse: Codable {
    let info: Info
    let results: [Episode]
}

// MARK: - Episode
struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}

// MARK: - Info (compartido con otros modelos como CharacterResponse)
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharacterBasic: Identifiable {
    let id: Int
    let name: String
    let image: String
    let gender: String
    let species: String
    let status: String
}

