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
}

final class DataManager: DataManagerProtocol {
    private let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func store(_ model: [LocationVisibleModel]) {
        dataStore.storeData(model: model)
    }
    
    func getNextPageItems(startIndex: Int = 0, itemsPerPage: Int) -> [LocationVisibleModel] {
        let storedValues = getItems()
        let endIndex = min(startIndex + itemsPerPage, storedValues.count)
        return Array(storedValues[startIndex..<endIndex])
    }
}

private extension DataManager {
    func getItems() -> [LocationVisibleModel] {
        return dataStore.getItems()
    }
}
