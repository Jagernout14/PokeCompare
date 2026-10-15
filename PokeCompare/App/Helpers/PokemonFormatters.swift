//
//  PokemonFormatters.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 09.10.2026.
//

import Foundation

enum PokemonFormatters {
    private static let formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter
    }()
    
    static func weight(_ hectograms: Int) -> String {
        let kilograms = Double(hectograms) / 10
        let measurement = Measurement(value: kilograms, unit: UnitMass.kilograms)
        return formatter.string(from: measurement)
    }
    
    static func height(_ decimeters: Int) -> String {
        let centimeters = Double(decimeters) * 10
        let measurement = Measurement(value: centimeters, unit: UnitLength.centimeters)
        return formatter.string(from: measurement)
    }
}

