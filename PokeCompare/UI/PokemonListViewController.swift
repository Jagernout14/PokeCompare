//
//  PokemonListViewController.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

//MARK: - MockData
struct MockPokemon {
    let name: String
    let number: Int
}

extension MockPokemon {
    static let list: [MockPokemon] = [
        MockPokemon(name: "bulbasaur", number: 1),
        MockPokemon(name: "ivysaur", number: 2),
        MockPokemon(name: "venusaur", number: 3),
        MockPokemon(name: "charmander", number: 4),
        MockPokemon(name: "charmeleon", number: 5),
        MockPokemon(name: "charizard", number: 6),
        MockPokemon(name: "squirtle", number: 7),
        MockPokemon(name: "wartortle", number: 8),
        MockPokemon(name: "blastoise", number: 9),
        MockPokemon(name: "pikachu", number: 25),
        MockPokemon(name: "mewtwo", number: 150),
        MockPokemon(name: "fletchinder", number: 662),
        MockPokemon(name: "crabominable", number: 740),
        MockPokemon(name: "corviknight", number: 823),
        MockPokemon(name: "squawkabilly", number: 931)
    ]
}


import UIKit

final class PokemonListViewController: UIViewController {
    
    // MARK: - Private Properties
    private let listView = PokemonListView()
    private let pokemons = MockPokemon.list
    
    // MARK: - Overrides Methods
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.tableView.dataSource = self
        
        
        title = "Pokémon"
    }
}

//MARK: - TableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.reuseIdentifier, for: indexPath) as? PokemonListCell else {
            return UITableViewCell()
        }
        
        let pokemon = pokemons[indexPath.row]
        cell.configure(name: pokemon.name, number: pokemon.number, isSelected: true)
        return cell
    }
}
