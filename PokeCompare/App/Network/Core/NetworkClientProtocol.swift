//
//  NetworkClientProtocol.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 06.10.2026.
//

import Foundation

protocol NetworkClientProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
