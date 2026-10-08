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
    let compareButton = UIButton(configuration: .filled())
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(resource: .pokeBackgroundGrey)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not be implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupTableView()
        setupCompareButton()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(resource: .pokeBackgroundGrey)
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        tableView.contentInset.bottom = 80
        tableView.verticalScrollIndicatorInsets.bottom = 80
    }
    
    private func setupCompareButton() {
        compareButton.configuration?.title = "Сравнить"
        compareButton.isEnabled = false
        
        compareButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(compareButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            compareButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            compareButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            compareButton.heightAnchor.constraint(equalToConstant: 50),
            compareButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
