//
//  VehicleViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum VehicleAction: FluxAction {
    case loaded(item: Vehicle)
    case failure
    case finished
}

final class VehicleStore: FluxStore {

    // MARK: - Types
    
    struct VehicleModel {
        let cargoCapacity, consumables, costInCredits, created: String
        let crew, edited, length, manufacturer: String
        let maxAtmospheringSpeed, model, name, passengers: String
        let pilots: [String]
        let films: [String]
        let url: String
        let vehicleClass: String
    }
    
    // MARK: - Properties
    
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var dispatcher: FluxDispatcher?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: VehicleModel
    let urlStringToFetch: String
    
    // MARK: - Inits
    
    init(from item: Vehicle) {
        loadState = .finished
        model = VehicleModel(cargoCapacity: item.cargo_capacity,
                              consumables: item.consumables,
                              costInCredits: item.cost_in_credits,
                              created: item.created,
                              crew: item.crew,
                              edited: item.edited,
                              length: item.length,
                              manufacturer: item.manufacturer,
                              maxAtmospheringSpeed: item.max_atmosphering_speed,
                              model: item.model,
                              name: item.name,
                              passengers: item.passengers,
                             pilots: item.pilots,
                             films: item.films,
                              url: item.url,
                             vehicleClass: item.vehicle_class)
        urlStringToFetch = item.url
    }
    
    init(urlString: String) {
        loadState = .idle
        model = VehicleModel(cargoCapacity: "",
                              consumables: "",
                              costInCredits: "",
                              created: "",
                              crew: "",
                              edited: "",
                              length: "",
                              manufacturer: "",
                              maxAtmospheringSpeed: "",
                              model: "",
                              name: "",
                              passengers: "",
                             pilots: [],
                              films: [],
                             url: "",
                            vehicleClass: "")
        urlStringToFetch = urlString
        dispatcher?.register(actionType: VehicleAction.self, for: self)
    }
    
    // MARK: - Flux store
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? VehicleAction
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
    
    private func didReceive(item: Vehicle) {
        loadState = .finished
        model = VehicleModel(cargoCapacity: item.cargo_capacity,
                             consumables: item.consumables,
                             costInCredits: item.cost_in_credits,
                             created: item.created,
                             crew: item.crew,
                             edited: item.edited,
                             length: item.length,
                             manufacturer: item.manufacturer,
                             maxAtmospheringSpeed: item.max_atmosphering_speed,
                             model: item.model,
                             name: item.name,
                             passengers: item.passengers,
                             pilots: item.pilots,
                             films: item.films,
                             url: item.url,
                             vehicleClass: item.vehicle_class)
    }
}
