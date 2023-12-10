//
//  NetworkRequest.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct NetworkRequest {
    let endPoint: URL?
    let httpMethod: HttpMethod
    let dto: Encodable?
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
