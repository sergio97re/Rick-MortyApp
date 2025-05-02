//
//  RootViewModel.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 24/03/2025.
//

import Foundation
import Combine

@Observable
final class RootViewModel {
    var status = Status.splash
    
    //Combine
    var suscriptors = Set<AnyCancellable>()
    
    
}
