//
//  ComparisonModels.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 09.10.2026.
//

enum StatComparisonResult {
    case higher
    case lower
    case equal
}

struct StatRow {
    let name: String
    let value: Int
    let comparison: StatComparisonResult
}

struct PokemonColumnDisplay {
    let imageURL: String
    let name: String
    let weight: String
    let height: String
    let stats: [StatRow]
}
