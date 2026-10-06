//
//  PokemonModel.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 26.09.2026.
//

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let stats: [PokemonStat]
    let sprites: Sprites
}

struct PokemonType: Decodable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Decodable {
    let name: String
}

struct PokemonStat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: StatDetail
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct StatDetail: Decodable {
    let name: String
}

struct Sprites: Decodable {
    let frontDefault: String?
    let other: OtherSprites
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
