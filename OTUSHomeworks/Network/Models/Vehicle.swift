//
//  Vehicle.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation

final class Vehicles: Decodable, ListModelProtocol {
    typealias ElementsType = Vehicle
    
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Vehicle]?
    
    static var sectionName: String {
        "vehicles"
    }
    
    var elements: [Vehicle] {
        results ?? []
    }
    
    var hasNextElement: Bool {
        next != nil
    }
    
    func elementName(element: Vehicle) -> String {
        return element.name
    }
}

final class Vehicle: Decodable, ModelProtocol {
    let cargo_capacity, consumables, cost_in_credits, created: String
    let crew, edited, length, manufacturer: String
    let max_atmosphering_speed, model, name, passengers: String
    let pilots: [String]
    let films: [String]
    let url: String
    let vehicle_class: String
    
    var modelName: String { name }
}
