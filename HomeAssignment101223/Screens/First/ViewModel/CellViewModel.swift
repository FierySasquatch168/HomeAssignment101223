//
//  CellViewModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

final class CellViewModel {
    @Published private (set) var cellModel: LocationVisibleModel
    @Published private (set) var cellState: CellStateEnum?
    
    init(cellModel: LocationVisibleModel) {
        self.cellModel = cellModel
        updateCellState(model: cellModel)
    }
}

// MARK: - Ext State management
private extension CellViewModel {
    func updateCellState(model: LocationVisibleModel) {
        if model.isLiked && model.imageURL == nil {
            cellState = .likedWithoutBackground
        } else if model.isLiked && model.imageURL != nil {
            cellState = .likedWithBackground
        } else {
            cellState = .ordinary
        }
    }
}
