//
//  LocationVisibleModel.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct LocationVisibleModel: Hashable {
    let id = UUID().uuidString
    let hebrewName: String
    let englishName: String
    let region: String
    let imageURL: URL?
    var isLiked: Bool
    
    init(location: Location, urlForImage: URL?) {
        self.hebrewName = location.hebrewName
        self.englishName = location.englishName
        self.region = location.region
        self.imageURL = urlForImage
        self.isLiked = false
    }
    
    mutating func toggleLike() {
        self.isLiked.toggle()
    }
}
