//
//  ViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation
import Combine

protocol ViewModelProtocol {
    var locations: CurrentValueSubject<[LocationVisibleModel], Never> { get }
}

final class ViewModel: ViewModelProtocol {
    var locations = CurrentValueSubject<[LocationVisibleModel], Never>([])
    
    private let networkService: LocationManager
    
    init(networkService: LocationManager) {
        self.networkService = networkService
        getLocations()
        
    }
    
    func getLocations() {
        Task {
            do {
                let response = try await networkService.getLocations()
                handleResponse(response)
            } catch {
                print("error caught: \(error)")
            }
        }
    }
    
    private func handleResponse(_ response: APIResponse) {
        let result = response.result.records.compactMap({ convert(location: $0) })
        locations.send(result)
    }
}

// MARK: - Ext Convert
private extension ViewModel {
    func convert(location: Location) -> LocationVisibleModel {
        let url = networkService.getUrl(string: location.regionalCouncil)
        return LocationVisibleModel(location: location, urlForImage: url)
    }
}
