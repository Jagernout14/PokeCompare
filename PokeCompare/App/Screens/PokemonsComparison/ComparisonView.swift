//
//  ComparisonView.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 12.10.2026.
//

import UIKit

final class ComparisonView: UIView {
    
    // MARK: - Private Properties
    private let firstColumn = PokemonColumnView()
    private let secondColumn = PokemonColumnView()
    private let spinner = UIActivityIndicatorView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(resource: .pokeBackgroundCardGrey)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(left: PokemonColumnDisplay, right: PokemonColumnDisplay) {
        firstColumn.configure(with: left)
        secondColumn.configure(with: right)
    }
    
    func setLoading(_ isLoading: Bool) {
        firstColumn.isHidden = isLoading
        secondColumn.isHidden = isLoading
        if isLoading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        firstColumn.translatesAutoresizingMaskIntoConstraints = false
        secondColumn.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstColumn)
        addSubview(secondColumn)
        addSubview(spinner)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstColumn.widthAnchor.constraint(equalTo: secondColumn.widthAnchor),
            firstColumn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            firstColumn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            secondColumn.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            secondColumn.topAnchor.constraint(equalTo: firstColumn.topAnchor),
            firstColumn.trailingAnchor.constraint(equalTo: secondColumn.leadingAnchor, constant: -16),
            spinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
