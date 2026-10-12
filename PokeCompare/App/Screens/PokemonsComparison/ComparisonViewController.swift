//
//  ComparisonViewController.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 12.10.2026.
//

import UIKit

final class ComparisonViewController: UIViewController {
    
    private let comparisonView = ComparisonView()
    
    override func loadView() {
        view = comparisonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MockData
        let pikachu = PokemonColumnDisplay(imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
                                           name: "Pikachu",
                                           weight: "6 kg",
                                           height: "40 cm",
                                           stats: [
                                            StatRow(name: "HP", value: 35, comparison: .lower),
                                            StatRow(name: "Attack", value: 55, comparison: .higher),
                                            StatRow(name: "Defense", value: 40, comparison: .equal)
                                           ]
        )
        let bulbasaur = PokemonColumnDisplay(imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
                                             name: "Bulbasaur",
                                             weight: "6 kg",
                                             height: "50 cm",
                                             stats: [
                                                StatRow(name: "HP", value: 45, comparison: .higher),
                                                StatRow(name: "Attack", value: 22, comparison: .lower),
                                                StatRow(name: "Defense", value: 40, comparison: .equal)
                                             ]
        )
        
        comparisonView.configure(left: pikachu, right: bulbasaur)
        
    }
}
