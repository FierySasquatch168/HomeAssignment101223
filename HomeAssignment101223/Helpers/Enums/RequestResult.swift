//
//  RequestResult.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

enum RequestResult {
    case loading
    
    var image: UIImage? {
        return UIImage(systemName: "circle.dotted")
    }
}
