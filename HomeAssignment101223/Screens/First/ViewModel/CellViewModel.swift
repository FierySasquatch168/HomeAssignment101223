//
//  CellViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

final class CellViewModel {
    @Published private (set) var cellModel: LocationVisibleModel
    
    init(cellModel: LocationVisibleModel) {
        self.cellModel = cellModel
    }
}