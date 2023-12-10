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
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath)
}

final class ViewModel: ViewModelProtocol {
    var locations = CurrentValueSubject<[LocationVisibleModel], Never>([])
    
    private lazy var locationsStore: [LocationVisibleModel] = []
    private lazy var itemsPerPage = 10
    
    private let networkService: LocationManager
    // MARK: Init
    init(networkService: LocationManager) {
        self.networkService = networkService
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
                locations.send(getFirstPageItems())
            } catch {
                print("error caught: \(error)")
            }
        }
    }
}

// MARK: - Ext Paging protocol
extension ViewModel: PagingProtocol {
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath) {
        let startIndex = locations.value.count
        let nextPageItems = calculateNextPageItems(startIndex: startIndex)
        
        guard !nextPageItems.isEmpty else { return }
        if indexPath.row == locations.value.count - 1 {
            locations.send(locations.value + nextPageItems)
        }
    }
}

// MARK: - Ext Handle response
private extension ViewModel {
    func handleResponse(_ response: APIResponse) {
        let result = response.result.records.compactMap({ convert(location: $0) })
        locationsStore.append(contentsOf: result)
    }
    
    func convert(location: Location) -> LocationVisibleModel {
        let url = networkService.getUrl(string: location.regionalCouncil)
        return LocationVisibleModel(location: location, urlForImage: url)
    }
}

// MARK: - Ext Pagination
private extension ViewModel {
    func getFirstPageItems() -> [LocationVisibleModel] {
        return Array(
            locationsStore
            .dropFirst(locations.value.count)
            .prefix(itemsPerPage)
        )
    }
    
    func calculateNextPageItems(startIndex: Int) -> [LocationVisibleModel] {
        let endIndex = min(startIndex + itemsPerPage, locationsStore.count)
        return Array(locationsStore[startIndex..<endIndex])
    }
}
