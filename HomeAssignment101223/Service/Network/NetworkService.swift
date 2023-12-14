//
//  NetworkService.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    mutating func sendNetworkRequest<T: Decodable>(request: NetworkRequest, type: T.Type) async throws -> T
    func cancelCurrentTask()
}

// MARK: BasicNetworkService
struct BasicNetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private var currentTask: URLSessionDataTask?

    init(decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: configuration)
        self.decoder = decoder
        self.encoder = encoder
    }
    
    mutating func sendNetworkRequest<T: Decodable>(request: NetworkRequest, type: T.Type) async throws -> T {
        let data = try await makeNetworkRequest(request: request)
        let parsedData = try parseResponse(data.0, data.1)
        return try decoder.decode(type, from: parsedData)
    }
    
    // Cancel the current task
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}

// MARK: - Ext Create URLRequest
private extension BasicNetworkService {
    func create(_ request: NetworkRequest) -> URLRequest? {
        guard let url = request.endPoint else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        if let dto = request.dto,
           let dtoEncoded = try? encoder.encode(dto) {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = dtoEncoded
        }
        return urlRequest
    }
}

// MARK: - Ext Parse response
private extension BasicNetworkService {
    func parseResponse(_ data: Data, _ response: URLResponse?) throws -> Data {
        // Check if the response is an HTTPURLResponse and has a status code
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check if the response status code is within the expected range (e.g., 200-299)
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse(httpResponse.statusCode)
        }
        
        return data
    }
}

private extension BasicNetworkService {
    mutating func makeNetworkRequest(request: NetworkRequest) async throws -> (Data, URLResponse) {
        guard let urlRequest = create(request) else { throw NetworkError.badRequest }
        // Cancel the current task if it exists
        cancelCurrentTask()
        
        // Create a new URLSessionDataTask
        let dataTask = session.dataTask(with: urlRequest)
        
        // Set the new task as the current task
        currentTask = dataTask
        
        // Start the new task
        dataTask.resume()
        
        // Use Task to await the completion of the data task
        let data = try await session.data(for: dataTask.currentRequest!)
        
        return data
    }
}
