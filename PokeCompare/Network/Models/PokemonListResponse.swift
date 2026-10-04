//
//  PokemonListResponse.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 03.10.2026.
//

struct PokemonListResponse: Decodable {
    let next: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable {
    let name: String
    let url: String
}
