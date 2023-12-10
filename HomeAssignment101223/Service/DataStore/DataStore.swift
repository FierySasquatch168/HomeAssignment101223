//
//  DataStore.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

protocol DataStoreProtocol {
    func getItems() -> [LocationVisibleModel]
    func storeData(model: [LocationVisibleModel])
    func toggleLike(for model: LocationVisibleModel)
}

final class DataStore{
    private lazy var locationsStore: [LocationVisibleModel] = []
}

// MARK: - Ext DataStoreProtocol
extension DataStore: DataStoreProtocol {
    func getItems() -> [LocationVisibleModel] {
        return locationsStore
    }
    
    func storeData(model: [LocationVisibleModel]) {
        self.locationsStore = model
    }
    
    func toggleLike(for model: LocationVisibleModel) {
        if let index = locationsStore.firstIndex(where: { $0.id == model.id }) {
            locationsStore[index].toggleLike()
        }
    }
}
