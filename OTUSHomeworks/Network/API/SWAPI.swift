//
//  SWAPI.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation
import Combine

struct NetworkError: Error {
    var error: String
}

final class SWAPI {
    private let baseUrl = "https://swapi.dev/api/"
    private let session = URLSession.shared
    
    static var shared = SWAPI()
    
    func fetchPeoplePage(pageNumber: Int) -> AnyPublisher<People, Error> {
        let urlString = "\(baseUrl)/people/?page=\(pageNumber)"
        let result: AnyPublisher<People, Error> = fetch(urlString: urlString)
        return result
    }
    
    func fetchFilmsPage(pageNumber: Int) -> AnyPublisher<Films, Error> {
        let urlString = "\(baseUrl)/films/?page\(pageNumber)"
        let result: AnyPublisher<Films, Error> = fetch(urlString: urlString)
        return result
    }
    
    func fetchStarhipsPage(pageNumber: Int) -> AnyPublisher<Starships, Error> {
        let urlString = "\(baseUrl)/starships/?page\(pageNumber)"
        let result: AnyPublisher<Starships, Error> = fetch(urlString: urlString)
        return result
    }
    
    func fetchVehiclesPage(pageNumber: Int) -> AnyPublisher<Vehicles, Error> {
        let urlString = "\(baseUrl)/vehicles/?page\(pageNumber)"
        let result: AnyPublisher<Vehicles, Error> = fetch(urlString: urlString)
        return result
    }
    
    func fetchSpeciesPage(pageNumber: Int) -> AnyPublisher<Species, Error> {
        let urlString = "\(baseUrl)/species/?page\(pageNumber)"
        let result: AnyPublisher<Species, Error> = fetch(urlString: urlString)
        return result
    }
    
    func fetchPlanetsPage(pageNumber: Int) -> AnyPublisher<Planets, Error> {
        let urlString = "\(baseUrl)/planets/?page\(pageNumber)"
        let result: AnyPublisher<Planets, Error> = fetch(urlString: urlString)
        return result
    }
    
    private func fetch<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError(error: "Invalid URL")).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap({ return try JSONDecoder().decode(T.self, from: $0.data) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
