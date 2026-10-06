//
//  EndpointProtocol.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 06.10.2026.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

extension Endpoint {
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
    var body: Encodable? { nil }
    
    func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.badUrl
        }
        
        components.queryItems = queryItems
        guard let url = components.url else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        if let headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw NetworkError.encodeError
            }
        }
        
        return request
    }
}
