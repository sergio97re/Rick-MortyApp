//
//  CharactersViewModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import Foundation
import Combine

@Observable
final class CharactersViewModel {
    var characters: [Character]?
    var status = Status.splash
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            getCharactersTesting()
        }else {
            getCharacters()
        }
    }
    
    func getCharacters(name: String = "") {
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getCharacters(name: name))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                ///Todo OK. Devuelvo Data
                return $0.data
            }
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error buscando personajes")
                case .finished:
                    self.status = .home
                }
            } receiveValue: { data in
                self.characters = data.results
            }
            .store(in: &suscriptors)
    }
    
    ///For Testing and UI Development
    func getCharactersTesting() {
        self.status = .loading
        
        self.status = .home
        self.characters = getCharactersMock()
    }
    
    ///For Previews
    func getCharactersMock() -> [Character] {
        let origin = Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1")
        let location = Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3")
        
        let character1 = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: origin,
            location: location,
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/1"
        )
        
        let character2 = Character(
            id: 2,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: origin,
            location: location,
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/2"
        )
        
        let character3 = Character(
            id: 3,
            name: "Summer Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Female",
            origin: origin,
            location: location,
            image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/6",
                "https://rickandmortyapi.com/api/episode/7"
            ],
            url: "https://rickandmortyapi.com/api/character/3"
        )
        
        return [character1, character2, character3]
    }
}
