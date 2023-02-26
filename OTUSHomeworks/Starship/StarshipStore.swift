//
//  StarshipViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum StarshipAction: FluxAction {
    case loaded(item: Starship?)
    case failure
}

final class StarshipStore: FluxStore {
    
    // MARK: - Types
      
    struct StarshipModel {
        let MGLT, cargoCapacity, consumables, costInCredits: String
        let created, crew, edited, hyperdriveRating: String
        let length, manufacturer, maxAtmospheringSpeed, model: String
        let name, passengers: String
        let films: [String]
        let pilots: [String]
        let starshipClass: String
        let url: String
    }
    
    // MARK: - Properties
    
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var dispatcher: FluxDispatcher?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: StarshipModel
    let urlStringToFetch: String
    
    // MARK: - Inits
    
    init(from item: Starship) {
        loadState = .finished
        model = StarshipModel(MGLT: item.MGLT,
                              cargoCapacity: item.cargo_capacity,
                              consumables: item.consumables,
                              costInCredits: item.cost_in_credits,
                              created: item.created,
                              crew: item.crew,
                              edited: item.edited,
                              hyperdriveRating: item.hyperdrive_rating,
                              length: item.length,
                              manufacturer: item.manufacturer,
                              maxAtmospheringSpeed: item.max_atmosphering_speed,
                              model: item.model,
                              name: item.name,
                              passengers: item.passengers,
                              films: item.films,
                              pilots: item.pilots,
                              starshipClass: item.starship_class,
                              url: item.url)
        urlStringToFetch = item.url
        dispatcher?.register(actionType: StarshipAction.self, for: self)
    }
    
    init(urlString: String) {
        loadState = .idle
        model = StarshipModel(MGLT: "",
                              cargoCapacity: "",
                              consumables: "",
                              costInCredits: "",
                              created: "",
                              crew: "",
                              edited: "",
                              hyperdriveRating: "",
                              length: "",
                              manufacturer: "",
                              maxAtmospheringSpeed: "",
                              model: "",
                              name: "",
                              passengers: "",
                              films: [],
                              pilots: [],
                              starshipClass: "",
                              url: "")
        urlStringToFetch = urlString
        dispatcher?.register(actionType: StarshipAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? StarshipAction
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
    
    private func didReceive(item: Starship?) {
        guard let item = item else { return }
        loadState = .finished
        model = StarshipModel(MGLT: item.MGLT,
                              cargoCapacity: item.cargo_capacity,
                              consumables: item.consumables,
                              costInCredits: item.cost_in_credits,
                              created: item.created,
                              crew: item.crew,
                              edited: item.edited,
                              hyperdriveRating: item.hyperdrive_rating,
                              length: item.length,
                              manufacturer: item.manufacturer,
                              maxAtmospheringSpeed: item.max_atmosphering_speed,
                              model: item.model,
                              name: item.name,
                              passengers: item.passengers,
                              films: item.films,
                              pilots: item.pilots,
                              starshipClass: item.starship_class,
                              url: item.url)
    }
}
