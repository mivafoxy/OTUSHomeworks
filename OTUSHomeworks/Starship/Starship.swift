//
//  Starship.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation
import SWAPICore

final class Starships: Decodable, ListModelProtocol {
    typealias ElementsType = Starship
    
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Starship]?
    
    static var sectionName: String {
        "starships"
    }
    
    var elements: [Starship] {
        results ?? []
    }
    
    var hasNextElement: Bool {
        next != nil
    }
    
    func elementName(element: Starship) -> String {
        return element.name
    }
}

final class Starship: Decodable, ModelProtocol {
    let MGLT, cargo_capacity, consumables, cost_in_credits: String
    let created, crew, edited, hyperdrive_rating: String
    let length, manufacturer, max_atmosphering_speed, model: String
    let name, passengers: String
    let films: [String]
    let pilots: [String]
    let starship_class: String
    let url: String
    
    var modelName: String { name }
}
