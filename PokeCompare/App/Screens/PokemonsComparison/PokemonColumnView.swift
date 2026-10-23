//
//  PokemonColumnView.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 10.10.2026.
//

import UIKit
import Kingfisher

final class PokemonColumnView: UIView {
    
    // MARK: - Private Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        weightLabel.textAlignment = .center
        weightLabel.textColor = .secondaryLabel
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        return weightLabel
    }()
    
    private let heightLabel: UILabel = {
        let heightLabel = UILabel()
        heightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        heightLabel.textAlignment = .center
        heightLabel.textColor = .secondaryLabel
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        return heightLabel
    }()
    
    private let statStackView: UIStackView = {
        let statStackView = UIStackView()
        statStackView.axis = .vertical
        statStackView.spacing = 4
        statStackView.translatesAutoresizingMaskIntoConstraints = false
        return statStackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with display: PokemonColumnDisplay) {
        imageView.kf.setImage(with: display.imageURL)
        nameLabel.text = display.name
        weightLabel.text = display.weight
        heightLabel.text = display.height
        
        for view in statStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        for stat in display.stats {
            let rowView = StatRowView()
            rowView.configure(with: stat)
            statStackView.addArrangedSubview(rowView)
        }
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(weightLabel)
        addSubview(heightLabel)
        addSubview(statStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 96),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 2),
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            statStackView.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 12),
            statStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
