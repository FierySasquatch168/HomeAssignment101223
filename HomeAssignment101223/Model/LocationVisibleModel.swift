//
//  LocationVisibleModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct LocationVisibleModel {
    let hebrewName: String
    let englishName: String
    let region: String
    let imageURL: URL?
    
    init(location: Location, urlForImage: URL?) {
        self.hebrewName = location.hebrewName
        self.englishName = location.englishName
        self.region = location.region
        self.imageURL = urlForImage
    }
}
