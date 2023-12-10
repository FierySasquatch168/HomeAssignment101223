//
//  DataManager.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

protocol DataManagerProtocol {
    func store(_ model: [LocationVisibleModel])
    func getNextPageItems(startIndex: Int, itemsPerPage: Int) -> [LocationVisibleModel]
    func toggleLike(for model: LocationVisibleModel)
}

final class DataManager {
    private let dataStore: DataStoreProtocol
    // MARK: Init
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
}

// MARK: - Ext DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func store(_ model: [LocationVisibleModel]) {
        dataStore.storeData(model: model)
    }
    
    func getNextPageItems(startIndex: Int = 0, itemsPerPage: Int) -> [LocationVisibleModel] {
        let storedValues = dataStore.getItems()
        let endIndex = min(startIndex + itemsPerPage, storedValues.count)
        return Array(storedValues[startIndex..<endIndex])
    }
    
    func toggleLike(for model: LocationVisibleModel) {
        dataStore.toggleLike(for: model)
    }
}
