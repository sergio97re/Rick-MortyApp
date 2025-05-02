//
//  LocationModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import Foundation

struct LocationResponse: Codable {
    let info: PageInfo
    let results: [LocationDetail]
}

struct LocationDetail: Identifiable, Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
