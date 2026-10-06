//
//  PokemonListView.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

import UIKit

final class PokemonListView: UIView {
    
    // MARK: - Public Properties
    let tableView = UITableView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(resource: .pokeBackgroundGrey)
        setupTableView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not be implemented")
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.backgroundColor = UIColor(resource: .pokeBackgroundGrey)
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
