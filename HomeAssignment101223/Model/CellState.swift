//
//  CellState.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

enum CellStateEnum {
    case likedWithoutBackground
    case likedWithBackground
    case ordinary
    
    var stateObject: CellState {
        switch self {
        case .likedWithoutBackground:
            return CellState(textColor: .black, backgroundColor: .systemPink)
        case .likedWithBackground:
            return CellState(textColor: .systemPink, backgroundColor: .clear)
        case .ordinary:
            return CellState(textColor: .black, backgroundColor: .clear)
        }
    }
}

struct CellState {
    let textColor: UIColor
    let backgroundColor: UIColor
}
