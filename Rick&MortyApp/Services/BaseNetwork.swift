//
//  BaseNetwork.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 24/03/2025.
//

import Foundation

//Constantes
let server = "https://rickandmortyapi.com/api"
let requestDefinition = "Content-type"

//Structs de metodos de red
struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    
    static let contentTypeJSON = "application/json"
}

enum endpoints: String {
    case characters = "/character"
    case locations = "/location"
    case episodes = "/episode"
}


struct BaseNetwork {
    
    ///Request de personajes
    func getCharacters(name: String = "") -> URLRequest {
        var urlComponents = URLComponents(string: "\(server)\(endpoints.characters.rawValue)")!
        
        if !name.isEmpty {
            urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        }
        
        ///Creamos la request
        var request: URLRequest = URLRequest(url: urlComponents.url!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    ///Request de locations
    func getLocations(name: String = "") -> URLRequest {
        var urlComponents = URLComponents(string: "\(server)\(endpoints.locations.rawValue)")!
        
        if !name.isEmpty {
            urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        }
        
        ///Creamos la request
        var request: URLRequest = URLRequest(url: urlComponents.url!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    ///Request de episodes
    func getEpisodes(name: String = "") -> URLRequest {
        var urlComponents = URLComponents(string: "\(server)\(endpoints.episodes.rawValue)")!
        
        if !name.isEmpty {
            urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        }
        
        ///Creamos la request
        var request: URLRequest = URLRequest(url: urlComponents.url!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
}
