//
//  Film.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation
import SWAPICore

final class Films: Decodable, ListModelProtocol {
    typealias ElementsType = Film
    
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Film]?
    
    static var sectionName: String {
        "films"
    }
    
    var elements: [Film] {
        results ?? []
    }
    
    var hasNextElement: Bool {
        next != nil
    }
    
    func elementName(element: Film) -> String {
        return element.title
    }
}

final class Film: Decodable, ModelProtocol {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let characters: [String]
    let planets: [String]
    let url: String
    let created: String
    let edited: String
    
    var modelName: String { title }
}
