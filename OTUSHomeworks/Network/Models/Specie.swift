//
//  Species.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

final class Species: Decodable, ListModelProtocol {
    typealias ElementsType = Specie
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [Specie]
    
    static var sectionName: String {
        "species"
    }
    
    var elements: [Specie] {
        results
    }
    
    var hasNextElement: Bool {
        next != nil
    }
}

final class Specie: Decodable, ModelProtocol {
    let average_height, average_lifespan, classification, created: String
    let designation, edited, eye_colors, hair_colors: String
    let homeworld: String
    let language, name: String
    let people, films: [String]
    let skin_colors: String
    let url: String
    
    var modelName: String { name }
}
