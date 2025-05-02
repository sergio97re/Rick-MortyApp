//
//  CharactersModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
    let info: PageInfo
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

struct CharactersFilter: Codable {
    var name: String
}
