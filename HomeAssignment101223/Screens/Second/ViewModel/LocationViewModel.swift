//
//  LocationViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

final class LocationViewModel: ObservableObject {
    @Published var isLiked = false
    
    let locationModel: LocationVisibleModel
    let dataManager: DataManagerProtocol
    
    init(locationModel: LocationVisibleModel,
         dataManager: DataManagerProtocol) {
        self.locationModel = locationModel
        self.dataManager = dataManager
    }
    
    func toggleLike() {
        dataManager.toggleLike(for: locationModel)
    }
}
