//
//  People.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

final class People: Decodable, ListModelProtocol {
    typealias ElementsType = Person
    
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Person]?
    
    static var sectionName: String {
        "people"
    }
    
    var elements: [Person] {
        results ?? []
    }
    
    var hasNextElement: Bool {
        next != nil
    }
    
    func elementName(element: Person) -> String {
        return element.name
    }
}

final class Person: Decodable, ModelProtocol {
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
    
    var modelName: String { name }
}
