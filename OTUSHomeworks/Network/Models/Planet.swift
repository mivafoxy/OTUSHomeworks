//
//  Planets.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

final class Planets: Decodable, ListModelProtocol {
    typealias ElementsType = Planet
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [Planet]
    
    static var sectionName: String {
        "planets"
    }
    
    var elements: [Planet] {
        results
    }
    
    var hasNextElement: Bool {
        next != nil
    }
}

final class Planet: Decodable, ModelProtocol {
    let climate, created, diameter, edited: String
    let films: [String]
    let gravity, name, orbital_period, population: String
    let residents: [String]
    let rotation_period, surface_water, terrain: String
    let url: String
    
    var modelName: String { name }
}
