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
    
    //MARK: - Public Properties
    var canCompare: Bool { selected.count == 2 }
    
    // MARK: - Private Properties
    private let client: NetworkClientProtocol
    private(set) var pokemons: [PokemonListItem] = []
    private(set) var selected: [PokemonListItem] = []
    
    private let limit = 20
    private var offset = 0
    private var isLoading = false
    private var hasMore = true
    
    // MARK: - Initializers
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func loadPokemons() {
        guard !isLoading, hasMore else {
            return
        }
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                let response: PokemonListResponse = try await client.request(PokemonEndpoint.list(limit: limit, offset: offset))
                hasMore = response.next != nil
                pokemons += response.results
                offset += limit
                onPokemonsUpdated?()
            } catch {
                let message = (error as? NetworkError)?.userMessage ?? "Что-то пошло не так"
                onError?(message)
            }
        }
    }
    
    func isSelected(_ item: PokemonListItem) -> Bool {
        selected.contains(item)
    }
    
    func toggleSelection(_ item: PokemonListItem) {
        if selected.contains(item) {
            selected.removeAll(where: {$0 == item})
        } else if selected.count == 2 {
            selected.removeFirst()
            selected.append(item)
        } else {
            selected.append(item)
        }
    }
}
