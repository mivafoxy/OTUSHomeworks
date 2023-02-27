//
//  PersonViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum PersonAction: FluxAction {
    case loaded(item: Person?)
    case failure
}

final class PersonStore: FluxStore {
    
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
    
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var dispatcher: FluxDispatcher?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: PersonModel
    let urlStringToFetch: String
    
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
        dispatcher?.register(actionType: PersonAction.self, for: self)
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
        dispatcher?.register(actionType: PersonAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? PersonAction
        else {
            return
        }
        
        switch action {
        case let .loaded(item):
            didReceive(response: item)
        case .failure:
            loadState = .error
        }
    }
    
    private func didReceive(response: Person?) {
        guard let response = response else { return }
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
