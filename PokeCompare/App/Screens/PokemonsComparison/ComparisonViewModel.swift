//
//  ComparisonViewModel.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 14.10.2026.
//

import Foundation

@MainActor
final class ComparisonViewModel {
    // MARK: - Private Properties
    private let client: NetworkClientProtocol
    private let leftName: String
    private let rightName: String
    
    // MARK: - Callbacks
    var onLoading: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    var onResult: ((PokemonColumnDisplay, PokemonColumnDisplay) -> Void)?
    
    // MARK: - Initializers
    init(client: NetworkClientProtocol, leftName: String, rightName: String) {
        self.client = client
        self.leftName = leftName
        self.rightName = rightName
    }
    
    // MARK: - Public Methods
    func load() {
        onLoading?(true)
        Task { [weak self] in
            guard let self else { return }
            defer { onLoading?(false) }
            do {
                async let left: Pokemon = client.request(PokemonEndpoint.details(name: leftName))
                async let right: Pokemon = client.request(PokemonEndpoint.details(name: rightName))
                let (leftPokemon, rightPokemon) = try await (left, right)
                
                let (leftDisplay, rightDisplay) = makeDisplays(left: leftPokemon, right: rightPokemon)
                onResult?(leftDisplay, rightDisplay)
            } catch {
                onError?(error)
            }
        }
    }
    
    // MARK: - Private Methods
    private func compare(_ value: Int, with other: Int) -> StatComparisonResult {
        if value > other {
            return .higher
        } else if value < other {
            return .lower
        } else {
            return .equal
        }
    }
    
    private func makeColumn(from pokemon: Pokemon, rows: [StatRow]) -> PokemonColumnDisplay {
        return PokemonColumnDisplay(
            imageURL: URL(string: pokemon.sprites.other.officialArtwork.frontDefault ?? ""),
            name: pokemon.name,
            weight: PokemonFormatters.weight(pokemon.weight),
            height: PokemonFormatters.height(pokemon.height),
            stats: rows
        )
    }
    
    private func makeDisplays(left: Pokemon, right: Pokemon) -> (PokemonColumnDisplay, PokemonColumnDisplay) {
        var leftRows: [StatRow] = []
        var rightRows: [StatRow] = []
        for (leftStat, rightStat) in zip(left.stats, right.stats) {
            leftRows.append(StatRow(name: leftStat.stat.name, value: leftStat.baseStat, comparison: compare(leftStat.baseStat, with: rightStat.baseStat)))
            rightRows.append(StatRow(name: rightStat.stat.name, value: rightStat.baseStat, comparison: compare(rightStat.baseStat, with: leftStat.baseStat)))
        }
        return (
            makeColumn(from: left, rows: leftRows),
            makeColumn(from: right, rows: rightRows)
        )
    }
}
