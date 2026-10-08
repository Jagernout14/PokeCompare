//
//  PokemonListCell.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//
import UIKit
import Kingfisher

final class PokemonListCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "PokemonListCell"
    
    // MARK: - Private Properties
    private let pokemonImage = UIImageView()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let stackView = UIStackView()
    private let checkmarkImage = UIImageView()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not be implemented")
    }
    
    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.kf.cancelDownloadTask()
        pokemonImage.image = UIImage(systemName: "questionmark.circle")
    }
    
    // MARK: - Public Methods
    func configure(name: String, number: Int, isSelected: Bool, spriteURL: URL?) {
        nameLabel.text = name.capitalized
        numberLabel.text = String(format: "#%03d", number)
        checkmarkImage.isHidden = !isSelected
        pokemonImage.kf.setImage(with: spriteURL, placeholder: UIImage(systemName: "questionmark.circle"))
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupImage()
        setupStackView()
        setupCheckmark()
        setupConstraints()
    }
    
    private func setupImage() {
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pokemonImage)
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        nameLabel.font = .systemFont(ofSize: 17,weight: .semibold)
        numberLabel.font = .systemFont(ofSize: 15, weight: .regular)
        nameLabel.textColor = UIColor(resource: .pokeMainTextBlack)
        numberLabel.textColor = UIColor(resource: .pokeSecondaryTextGrey)
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberLabel)
    }
    
    private func setupCheckmark() {
        checkmarkImage.image = UIImage(systemName: "checkmark.circle.fill")
        checkmarkImage.tintColor = UIColor(resource: .pokeRed)
        checkmarkImage.contentMode = .scaleAspectFit
        checkmarkImage.isHidden = true
        
        checkmarkImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(checkmarkImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.widthAnchor.constraint(equalToConstant: 56),
            pokemonImage.heightAnchor.constraint(equalTo: pokemonImage.widthAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            checkmarkImage.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImage.heightAnchor.constraint(equalTo: checkmarkImage.widthAnchor),
            checkmarkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: checkmarkImage.leadingAnchor, constant: -12)
        ])
    }
}
