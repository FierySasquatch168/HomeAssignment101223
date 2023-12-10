//
//  Location.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct APIResponse : Decodable {
    let result: APIResults
}

struct APIResults: Decodable {
    let records: [Location]
}

struct Location: Decodable {
    let hebrewName: String
    let englishName: String
    let region: String
    let regionalCouncil: String?
    
    enum CodingKeys: String, CodingKey {
        case hebrewName = "city_name_he"
        case englishName = "city_name_en"
        case region = "region_name"
        case regionalCouncil = "Regional_Council_name"
    }
}
