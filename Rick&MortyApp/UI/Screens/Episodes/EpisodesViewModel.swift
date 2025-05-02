//
//  EpisodesViewModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import Foundation
import Combine

@Observable
final class EpisodesViewModel {
    var episodes: [Episode]?
    var status = Status.splash
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            getEpisodesTesting()
        }else {
            getEpisodes()
        }
    }
    
    func getEpisodes(name: String = "") {
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getEpisodes(name: name))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                ///Todo OK. Devuelvo Data
                return $0.data
            }
            .decode(type: EpisodeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error buscando localizaciones")
                case .finished:
                    self.status = .home
                }
            } receiveValue: { data in
                self.episodes = data.results
            }
            .store(in: &suscriptors)
    }
    
    ///For Testing and UI Development
    func getEpisodesTesting() {
        self.episodes = getEpisodesMock()
    }
    
    /// For Previews
    func getEpisodesMock() -> [Episode] {
        let episode1 = Episode(
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
        )

        let episode2 = Episode(
            id: 2,
            name: "Lawnmower Dog",
            airDate: "December 9, 2013",
            episode: "S01E02",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/38"
            ],
            url: "https://rickandmortyapi.com/api/episode/2",
            created: "2017-11-10T12:56:33.916Z"
        )

        let episode3 = Episode(
            id: 3,
            name: "Anatomy Park",
            airDate: "December 16, 2013",
            episode: "S01E03",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/3"
            ],
            url: "https://rickandmortyapi.com/api/episode/3",
            created: "2017-11-10T12:56:34.022Z"
        )

        return [episode1, episode2, episode3]
    }


}
