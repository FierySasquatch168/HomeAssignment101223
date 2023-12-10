//
//  ViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation
import Combine

final class ViewModel: ViewModelProtocol & LoadingViewModelProtocol {
    var locations = CurrentValueSubject<[LocationVisibleModel], Never>([])
    var requestResult = CurrentValueSubject<RequestResult?, Never>(nil)
    
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var itemsPerPage = 10
    
    private let networkService: LocationManager
    private let dataManager: DataManagerProtocol
    
    // MARK: Init
    init(networkService: LocationManager,
         dataManager: DataManagerProtocol) {
        self.networkService = networkService
        self.dataManager = dataManager
        getLocations()
        bindDataManager()
    }
}

// MARK: - Ext Bind
private extension ViewModel {
    func bindDataManager() {
        dataManager.toggledLike
            .sink { [weak self] id in
                self?.toggleLike(id)
            }.store(in: &cancellables)
    }
    
    func toggleLike(_ id: String) {
        var updatedLocations = locations.value
        
        if let index = updatedLocations.firstIndex(where: { $0.id == id }) {
            updatedLocations[index].toggleLike()
            locations.send(updatedLocations)
        }
    }
}

// MARK: - Ext Network request
private extension ViewModel {
    func getLocations() {
        Task {
            do {
                requestResult.send(.loading)
                let response = try await networkService.getLocations()
                handleResponse(response)
                updateNextPageIfNeeded(forRowAt: nil)
                print("request nilled")
                requestResult.send(nil)
            } catch {
                // TODO: Show alert
                print("error caught: \(error)")
            }
        }
    }
}

// MARK: - Ext Paging protocol
extension ViewModel: PagingProtocol {
    func updateNextPageIfNeeded(forRowAt indexPath: IndexPath?) {
        let nextPageItems = nextPageItems()
        guard !nextPageItems.isEmpty else { return }
        if isReadyToSendNew(forRowAt: indexPath) { locations.send(locations.value + nextPageItems) }
    }
    
    private func nextPageItems() -> [LocationVisibleModel] {
        let startIndex = locations.value.count
        return dataManager.getNextPageItems(startIndex: startIndex, itemsPerPage: itemsPerPage)
    }
    
    private func isReadyToSendNew(forRowAt indexPath: IndexPath?) -> Bool {
        guard let indexPath else {
            return true
        }
        
        return indexPath.row == locations.value.count - 1
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
