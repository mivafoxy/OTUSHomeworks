//
//  Starship.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

struct Starships: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Starship]
}

struct Starship: Decodable {
    let mglt, cargoCapacity, consumables, costInCredits: String
    let created, crew, edited, hyperdriveRating: String
    let length, manufacturer, maxAtmospheringSpeed, model: String
    let name, passengers: String
    let films: [String]
    let pilots: [String]
    let starshipClass: String
    let url: String
}
