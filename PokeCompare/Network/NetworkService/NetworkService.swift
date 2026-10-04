//
//  NetworkService.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    private let baseUrlString = "https://pokeapi.co/api/v2/pokemon"
    
    private init() {}
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        guard var components = URLComponents(string: baseUrlString) else {
            throw NetworkError.badUrl
        }
        
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        
        guard let url = components.url else {
            throw NetworkError.badUrl
        }
        
        return try await fetchRequest(url: url)
    }
    
    func fetchPokemon(name: String) async throws -> Pokemon {
        guard let url = URL(string: baseUrlString + "/" + name.lowercased()) else {
            throw NetworkError.badUrl
        }
        
        return try await fetchRequest(url: url)
    }
    
    private func fetchRequest<T: Decodable>(url: URL) async throws -> T {
        let request = URLRequest(url: url)
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkError.noInternet
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw NetworkError.authorizationProblem
        case 400...499:
            throw NetworkError.clientError(httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknownError
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError
        }
    }
}
