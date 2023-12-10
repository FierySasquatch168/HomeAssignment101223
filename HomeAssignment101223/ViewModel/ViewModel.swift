//
//  ViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation
import Combine

protocol ViewModelProtocol {
    var locations: CurrentValueSubject<[Location], Never> { get }
}

final class ViewModel: ViewModelProtocol {
    var locations = CurrentValueSubject<[Location], Never>([])
    
    private let networkService: LocationManager
    
    init(networkService: LocationManager) {
        self.networkService = networkService
        getLocations()
        
    }
    
    func getLocations() {
        Task {
            do {
                let test = try await networkService.getLocations()
                locations.send(test.result.records)
            } catch {
                print("error caught: \(error)")
            }
        }
    }
}
