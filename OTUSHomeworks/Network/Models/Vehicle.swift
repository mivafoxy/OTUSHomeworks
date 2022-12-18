//
//  Vehicle.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

struct Vehicles: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Vehicle]
}

struct Vehicle: Decodable {
    let cargoCapacity, consumables, costInCredits, created: String
    let crew, edited, length, manufacturer: String
    let maxAtmospheringSpeed, model, name, passengers: String
    let pilots: [String]
    let films: [String]
    let url: String
    let vehicleClass: String
}
