//
//  PokemonListViewModel.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 06.10.2026.
//

@MainActor
final class PokemonListViewModel {
    
    // MARK: - Callbacks
    var onPokemonsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - Private Properties
    private let client: NetworkClientProtocol
    private(set) var pokemons: [PokemonListItem] = []
    
    private let limit = 20
    private var offset = 0
    
    // MARK: - Initializers
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func loadPokemons() {
        Task {
            do {
                let response: PokemonListResponse = try await client.request(PokemonEndpoint.list(limit: limit, offset: offset))
                pokemons += response.results
                offset += limit
                onPokemonsUpdated?()
            } catch {
                let message = (error as? NetworkError)?.userMessage ?? "Что-то пошло не так"
                onError?(message)
            }
        }
    }
}
