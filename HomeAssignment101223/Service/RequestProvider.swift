//
//  RequestProvider.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct RequestProvider {
    static func locationsRequest(endPoint: EndPointValue,
                                 httpMethod: HttpMethod,
                                 dto: Encodable?) -> NetworkRequest {
        
        return NetworkRequest(endPoint: URL(string: EndPointValue.main.stringValue),
                              httpMethod: httpMethod,
                              dto: dto)
    }
    
    static func createUrlFrom(string: String?) -> URL? {
        guard let string else { return nil }
        return URL(string: EndPointValue.image.stringValue)
    }
}

enum EndPointValue {
    case main
    case image
    
    var stringValue: String {
        switch self {
        case .main:
            return "https://data.gov.il/api/3/action/datastore_search?resource_id=8f714b6f-c35c-4b40-a0e7-547b675eee0e&limit=30"
        case .image:
            return "https://picsum.photos/500/250"
        }
    }
}
