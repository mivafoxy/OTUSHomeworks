//
//  Species.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

struct Species: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Specie]
}

struct Specie: Decodable {
    let averageHeight, averageLifespan, classification, created: String
    let designation, edited, eyeColors, hairColors: String
    let homeworld: String
    let language, name: String
    let people, films: [String]
    let skinColors: String
    let url: String
}
