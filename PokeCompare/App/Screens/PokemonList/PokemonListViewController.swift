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
        listView.tableView.delegate = self
        bind()
        viewModel.loadPokemons()
        setupActions()
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
    
    private func setupActions() {
        listView.compareButton.addTarget(self, action: #selector(compareTapped), for: .touchUpInside)
    }
    
    @objc private func compareTapped() {
        guard viewModel.canCompare else {
            return
        }
        let leftName = viewModel.selected[0].name
        let rightName = viewModel.selected[1].name
        
        let client = NetworkClient()
        let comparisonViewModel = ComparisonViewModel(client: client, leftName: leftName, rightName: rightName)
        let comparisonViewController = ComparisonViewController(viewModel: comparisonViewModel)
        navigationController?.pushViewController(comparisonViewController, animated: true)
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
        cell.configure(name: pokemon.name, number: pokemon.id ?? 0, isSelected: viewModel.isSelected(pokemon), spriteURL: pokemon.spriteURL)
        return cell
    }
}

//MARK: - TableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemons[indexPath.row]
        viewModel.toggleSelection(pokemon)
        listView.compareButton.isEnabled = viewModel.canCompare
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.pokemons.count - 1 {
            viewModel.loadPokemons()
        }
    }
}
