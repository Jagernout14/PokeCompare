//
//  PokemonListViewController.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    // MARK: - Private Properties
    private let listView = PokemonListView()
    private let viewModel: PokemonListViewModel
    
    // MARK: - Initializers
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides Methods
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.tableView.dataSource = self
        bind()
        viewModel.loadPokemons()
        title = "Pokémon"
    }
    
    // MARK: - Private Methods
    private func bind() {
        viewModel.onPokemonsUpdated = { [weak self] in
            self?.listView.tableView.reloadData()
        }
        viewModel.onError = { message in
            print(message)
        }
    }
}

//MARK: - TableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.reuseIdentifier, for: indexPath) as? PokemonListCell else {
            return UITableViewCell()
        }
        
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.configure(name: pokemon.name, number: indexPath.row + 1, isSelected: true)
        return cell
    }
}
