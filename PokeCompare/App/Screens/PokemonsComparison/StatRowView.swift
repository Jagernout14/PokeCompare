//
//  StatRowView.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 09.10.2026.
//

import UIKit

final class StatRowView: UIView {
    
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        layer.cornerRadius = 8
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(valueLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8)
        ])
    }
    
    func configure(with row: StatRow) {
        nameLabel.text = row.name
        valueLabel.text = String(row.value)
        
        switch row.comparison {
        case .higher:
            backgroundColor = .systemGreen.withAlphaComponent(0.2)
        case .lower:
            backgroundColor = .systemRed.withAlphaComponent(0.2)
        case .equal:
            backgroundColor = .systemOrange.withAlphaComponent(0.2)
        }
    }
}
