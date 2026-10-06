//
//  PokemonEndpoint.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 06.10.2026.
//

import Foundation

enum PokemonEndpoint: Endpoint {
    
    case list(limit: Int, offset: Int)
    case details(name: String)
    
    var baseURL: String {
        "https://pokeapi.co/api/v2"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/pokemon"
        case .details(let name):
            return "/pokemon/\(name.lowercased())"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        case .details:
            return nil
        }
    }
}
