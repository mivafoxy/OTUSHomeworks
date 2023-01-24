//
//  VehicleViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

final class VehicleViewModel: ObservableObject {
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
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    @Injected var networkService: SWAPIServiceProtocol?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: VehicleModel
    
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
    }
    
    // MARK: - Network methods
    
    func fetchStarship() {
        loadState = .loading
        networkService?
            .fetchItem(
                urlString: urlStringToFetch)
            .timeout(
                .seconds(waitTimeInSec),
                scheduler: DispatchQueue.main,
                customError: { SWAPIError.timeoutError })
            .sink(
                receiveCompletion: didReceive(completion:),
                receiveValue: didReceive(item:))
            .store(
                in: &anyCancellables)
    }
    
    private func didReceive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            loadState = .finished
        case .failure:
            loadState = .error
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
