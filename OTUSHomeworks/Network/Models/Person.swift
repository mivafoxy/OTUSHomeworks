//
//  People.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

struct People: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
}

struct Person: Decodable {
    let name: String
    let birth_year: String
    let eye_color: String
    let gender: String
    let hair_color: String
    let height: String
    let mass: String
    let skin_color: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let url: String
    let created: String
    let edited: String
}
