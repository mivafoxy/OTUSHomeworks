//
//  SWAPI.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Foundation
import Combine

enum SWAPIError: Error {
    case timeoutError
    case networkError
}

final class SWAPI {
    private let baseUrl = "https://swapi.dev/api/"
    private let session = URLSession.shared
    
    static var shared = SWAPI()
    
    func fetchItemsPage<T: Decodable & ListModelProtocol>(
        pageNumber: Int,
        sectionName: String
    ) -> AnyPublisher<T, Error> {
        let urlString = "\(baseUrl)/\(sectionName)/?page=\(pageNumber)"
        let result: AnyPublisher<T, Error> = fetch(urlString: urlString)
        return result
    }
    
    private func fetch<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: SWAPIError.networkError).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap({ try JSONDecoder().decode(T.self, from: $0.data) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
