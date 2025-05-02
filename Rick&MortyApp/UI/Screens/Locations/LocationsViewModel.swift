//
//  LocationsViewModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 16/04/2025.
//

import Foundation
import Combine

@Observable
final class LocationsViewModel {
    var locations: [LocationDetail]?
    var status = Status.splash
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            getLocationsTesting()
        }else {
            getLocations()
        }
    }
    
    func getLocations(name: String = "") {
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getLocations(name: name))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                ///Todo OK. Devuelvo Data
                return $0.data
            }
            .decode(type: LocationResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error buscando localizaciones")
                case .finished:
                    self.status = .home
                }
            } receiveValue: { data in
                self.locations = data.results
            }
            .store(in: &suscriptors)
    }
    
    ///For Testing and UI Development
    func getLocationsTesting() {
        self.locations = getLocationsMock()
    }
    
    ///For Previews
    func getLocationsMock() -> [LocationDetail] {
        let location1 = LocationDetail(
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
        
        let location2 = LocationDetail(
            id: 2,
            name: "Citadel of Ricks",
            type: "Space station",
            dimension: "unknown",
            residents: [
                "https://rickandmortyapi.com/api/character/3",
                "https://rickandmortyapi.com/api/character/4"
            ],
            url: "https://rickandmortyapi.com/api/location/3",
            created: "2017-11-10T13:08:13.191Z"
        )
        
        let location3 = LocationDetail(
            id: 3,
            name: "Interdimensional Cable",
            type: "TV",
            dimension: "unknown",
            residents: [
                "https://rickandmortyapi.com/api/character/20"
            ],
            url: "https://rickandmortyapi.com/api/location/6",
            created: "2017-11-10T13:09:09.102Z"
        )
        
        return [location1, location2, location3]
    }

}
