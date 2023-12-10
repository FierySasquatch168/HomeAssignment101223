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

protocol PagingProtocol {
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath?)
}

final class ViewModel: ViewModelProtocol {
    var locations = CurrentValueSubject<[LocationVisibleModel], Never>([])
    
    private lazy var itemsPerPage = 10
    
    private let networkService: LocationManager
    private let dataManager: DataManagerProtocol
    
    // MARK: Init
    init(networkService: LocationManager,
         dataManager: DataManagerProtocol) {
        self.networkService = networkService
        self.dataManager = dataManager
        getLocations()
    }
}

// MARK: - Ext Network request
private extension ViewModel {
    func getLocations() {
        Task {
            do {
                let response = try await networkService.getLocations()
                handleResponse(response)
                updateNextPageIfNeeded(forRowAt: nil)
            } catch {
                print("error caught: \(error)")
            }
        }
    }
}

// MARK: - Ext Paging protocol
extension ViewModel: PagingProtocol {
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath?) {
        let startIndex = locations.value.count
        let nextPageItems = dataManager.getNextPageItems(startIndex: startIndex, itemsPerPage: itemsPerPage)
        
        guard !nextPageItems.isEmpty else { return }
        
        // Check if indexPath is provided and if it's the last row
        if let indexPath = indexPath, indexPath.row == locations.value.count - 1 {
            locations.send(locations.value + nextPageItems)
        } else if indexPath == nil {
            // If indexPath is nil, update locations unconditionally
            locations.send(locations.value + nextPageItems)
        }
    }
}

// MARK: - Ext Handle response
private extension ViewModel {
    func convert(location: Location) -> LocationVisibleModel {
        let url = networkService.getUrl(string: location.regionalCouncil)
        return LocationVisibleModel(location: location, urlForImage: url)
    }
    
    func handleResponse(_ response: APIResponse) {
        let result = response.result.records.compactMap({ convert(location: $0) })
        dataManager.store(result)
    }
}
