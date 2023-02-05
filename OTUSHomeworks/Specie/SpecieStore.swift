//
//  SpecieViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum SpecieAction: FluxAction {
    case loaded(item: Specie)
    case failure
    case finished
}

final class SpecieStore: FluxStore {
    
    // MARK: - Types
    
    struct SpecieModel {
        let name: String
        let classification: String
        let designation: String
        let averageHeight: String
        let averageLifespan: String
        let eyeColors: String
        let hairColors: String
        let skinColors: String
        let language: String
        let homeworld: String?
        let people: [String]
        let films: [String]
        let url: String
        let created: String
        let edited: String
    }
    
    // MARK: - Properties
    
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: SpecieModel
    @Injected private var dispatcher: AppDispatcher?
    let urlStringToFetch: String
    
    // MARK: - Inits
    
    init(from item: Specie) {
        loadState = .finished
        model = SpecieModel(name: item.name,
                            classification: item.classification,
                            designation: item.designation,
                            averageHeight: item.average_height,
                            averageLifespan: item.average_lifespan,
                            eyeColors: item.eye_colors,
                            hairColors: item.hair_colors,
                            skinColors: item.skin_colors,
                            language: item.language,
                            homeworld: item.homeworld,
                            people: item.people,
                            films: item.films,
                            url: item.url,
                            created: item.created,
                            edited: item.edited)
        urlStringToFetch = item.url
        dispatcher?.register(actionType: SpecieAction.self, for: self)
    }
    
    init(urlString: String) {
        loadState = .idle
        model = SpecieModel(name: "",
                            classification: "",
                            designation: "",
                            averageHeight: "",
                            averageLifespan: "",
                            eyeColors: "",
                            hairColors: "",
                            skinColors: "",
                            language: "",
                            homeworld: "",
                            people: [],
                            films: [],
                            url: "",
                            created: "",
                            edited: "")
        urlStringToFetch = urlString
        dispatcher?.register(actionType: SpecieAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? SpecieAction
        else {
            return
        }
        
        switch action {
        case let .loaded(item):
            didReceive(item: item)
        case .failure:
            loadState = .error
        case .finished:
            loadState = .finished
        }
    }
    
    private func didReceive(item: Specie) {
        loadState = .finished
        model = SpecieModel(name: item.name,
                            classification: item.classification,
                            designation: item.designation,
                            averageHeight: item.average_height,
                            averageLifespan: item.average_lifespan,
                            eyeColors: item.eye_colors,
                            hairColors: item.hair_colors,
                            skinColors: item.skin_colors,
                            language: item.language,
                            homeworld: item.homeworld,
                            people: item.people,
                            films: item.films,
                            url: item.url,
                            created: item.created,
                            edited: item.edited)
    }
}
