//
//  DataStore.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

protocol DataStoreProtocol {
    func getItems() -> [LocationVisibleModel]
    func getItemsCount() -> Int
    func storeData(model: [LocationVisibleModel])
}

final class DataStore: DataStoreProtocol{
    private lazy var locationsStore: [LocationVisibleModel] = []
}

// MARK: - Ext DataStoreProtocol
extension DataStore {
    func getItems() -> [LocationVisibleModel] {
        return locationsStore
    }
    
    func storeData(model: [LocationVisibleModel]) {
        self.locationsStore = model
    }
    
    func getItemsCount() -> Int {
        return locationsStore.count
    }
}
