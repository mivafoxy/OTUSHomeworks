//
//  PlanetViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum PlanetAction: FluxAction {
    case loaded(item: Planet?)
    case failure
}

final class PlanetStore: FluxStore {
    // MARK: - Types
    
    struct PlanetModel {
        let climate, created, diameter, edited: String
        let films: [String]
        let gravity, name, orbitalPeriod, population: String
        let residents: [String]
        let rotationPeriod, surfaceWater, terrain: String
        let url: String
    }
    
    // MARK: - Properties
    
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var dispatcher: FluxDispatcher?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: PlanetModel
    let urlStringToFetch: String
    
    // MARK: - Inits
    
    init(from item: Planet) {
        loadState = .finished
        model = PlanetModel(climate: item.climate,
                            created: item.created,
                            diameter: item.diameter,
                            edited: item.edited,
                            films: item.films,
                            gravity: item.gravity,
                            name: item.name,
                            orbitalPeriod: item.orbital_period,
                            population: item.population,
                            residents: item.residents,
                            rotationPeriod: item.rotation_period,
                            surfaceWater: item.surface_water,
                            terrain: item.terrain,
                            url: item.url)
        urlStringToFetch = item.url
        dispatcher?.register(actionType: PlanetAction.self, for: self)
    }
    
    init(urlString: String) {
        loadState = .idle
        model = PlanetModel(climate: "",
                            created: "",
                            diameter: "",
                            edited: "",
                            films: [],
                            gravity: "",
                            name: "",
                            orbitalPeriod: "",
                            population: "",
                            residents: [],
                            rotationPeriod: "",
                            surfaceWater: "",
                            terrain: "",
                            url: "")
        urlStringToFetch = urlString
        dispatcher?.register(actionType: PlanetAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? PlanetAction
        else {
            return
        }
        
        switch action {
        case let .loaded(item):
            didReceive(item: item)
        case .failure:
            loadState = .error
        }
    }
    
    private func didReceive(item: Planet?) {
        guard let item = item else { return }
        loadState = .finished
        model = PlanetModel(climate: item.climate,
                            created: item.created,
                            diameter: item.diameter,
                            edited: item.edited,
                            films: item.films,
                            gravity: item.gravity,
                            name: item.name,
                            orbitalPeriod: item.orbital_period,
                            population: item.population,
                            residents: item.residents,
                            rotationPeriod: item.rotation_period,
                            surfaceWater: item.surface_water,
                            terrain: item.terrain,
                            url: item.url)
    }
}
