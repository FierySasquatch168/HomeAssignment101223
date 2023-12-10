//
//  LocationViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

final class LocationViewModel: ObservableObject {
    var isLiked: Bool = false
    
    let locationModel: LocationVisibleModel
    
    init(locationModel: LocationVisibleModel) {
        self.locationModel = locationModel
    }
    
    func toggleLike() {
        isLiked.toggle()
    }
}
