//
//  Species.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation
import SWAPICore

final class Species: Decodable, ListModelProtocol {
    typealias ElementsType = Specie
    
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Specie]?
    
    static var sectionName: String {
        "species"
    }
    
    var elements: [Specie] {
        results ?? []
    }
    
    var hasNextElement: Bool {
        next != nil
    }
}

final class Specie: Decodable, ModelProtocol {
    let name: String
    let classification: String
    let designation: String
    let average_height: String
    let average_lifespan: String
    let eye_colors: String
    let hair_colors: String
    let skin_colors: String
    let language: String
    let homeworld: String?
    let people: [String]
    let films: [String]
    let url: String
    let created: String
    let edited: String
    
    var modelName: String { name }
}
