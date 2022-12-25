//
//  PersonViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine

final class PersonViewModel: ObservableObject {
    
    // MARK: - Types
    
    struct PersonModel {
        let name: String
        let birthYear: String
        let eyeColor: String
        let gender: String
        let hairColor: String
        let height: String
        let mass: String
        let skinColor: String
        let homeworld: String
        let films: [String]
        let species: [String]
        let starships: [String]
        let vehicles: [String]
        let created: String
        let edited: String
    }
    
    // MARK: - Properties
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var loadState: ViewModelLoadState
    @Published var model: PersonModel
    
    // MARK: - Init
    
    init(from item: Person) {
        loadState = .finished
        model = PersonModel(name: item.name,
                            birthYear: item.birth_year,
                            eyeColor: item.eye_color,
                            gender: item.gender,
                            hairColor: item.hair_color,
                            height: item.height,
                            mass: item.mass,
                            skinColor: item.skin_color,
                            homeworld: item.homeworld,
                            films: item.films,
                            species: item.species,
                            starships: item.starships,
                            vehicles: item.vehicles,
                            created: item.created,
                            edited: item.edited)
        urlStringToFetch = item.url
    }
    
    init(urlString: String) {
        loadState = .idle
        urlStringToFetch = urlString
        model = PersonModel(name: "",
                            birthYear: "",
                            eyeColor: "",
                            gender: "",
                            hairColor: "",
                            height: "",
                            mass: "",
                            skinColor: "",
                            homeworld: "",
                            films: [],
                            species: [],
                            starships: [],
                            vehicles: [],
                            created: "",
                            edited: "")
    }
    
    // MARK: - Network methods
    
    func fetchPerson() {
        loadState = .loading
        SWAPI.shared
            .fetchItem(urlString: urlStringToFetch)
            .timeout(.seconds(waitTimeInSec),
                     scheduler: DispatchQueue.main,
                     customError: { SWAPIError.timeoutError })
            .sink(receiveCompletion: didReceive(completion:),
                  receiveValue: didReceive(response:))
            .store(in: &anyCancellables)
    }
    
    private func didReceive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            loadState = .finished
        case .failure:
            loadState = .error
        }
    }
    
    private func didReceive(response: Person) {
        loadState = .finished
        model = PersonModel(name: response.name,
                            birthYear: response.birth_year,
                            eyeColor: response.eye_color,
                            gender: response.gender,
                            hairColor: response.hair_color,
                            height: response.height,
                            mass: response.mass,
                            skinColor: response.skin_color,
                            homeworld: response.homeworld,
                            films: response.films,
                            species: response.species,
                            starships: response.starships,
                            vehicles: response.vehicles,
                            created: response.created,
                            edited: response.edited)
    }
}
