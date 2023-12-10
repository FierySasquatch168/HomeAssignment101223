//
//  NetworkError.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case addressUnreachable
    case invalidResponse
    case badResponse(Int)
    case badRequest
    case genericError(String)
    case parseError
    case failedToRetrieveSubscriptionTypeFromServer
}
