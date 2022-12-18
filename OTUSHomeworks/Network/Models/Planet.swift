//
//  Planets.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

struct Planets: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Planet]
}

struct Planet: Decodable {
    let climate, created, diameter, edited: String
    let films: [String]
    let gravity, name, orbitalPeriod, population: String
    let residents: [String]
    let rotationPeriod, surfaceWater, terrain: String
    let url: String
}
