//
//  NetworkManager.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

protocol LocationManager {
    func getLocations() async throws -> APIResponse
    func getUrl(string: String?) -> URL?
}

final class NetworkManager {
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension NetworkManager: LocationManager {
    func getLocations() async throws -> APIResponse {
        let request = RequestProvider.locationsRequest(endPoint: .main, httpMethod: .get, dto: nil)
        return try await networkService.sendNetworkRequest(request: request, type: APIResponse.self)
    }
    
    func getUrl(string: String?) -> URL? {
        return RequestProvider.createUrlFrom(string: string)
    }
}
