//
//  PokemonListResponse.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 03.10.2026.
//

import Foundation

struct PokemonListResponse: Decodable {
    let next: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Equatable {
    let name: String
    let url: String
}

extension PokemonListItem {
    var id: Int? {
        guard let url = URL(string:url) else { return nil }
        return Int(url.lastPathComponent)
    }
}
