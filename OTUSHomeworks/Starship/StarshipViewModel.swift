//
//  StarshipViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

final class StarshipViewModel: ObservableObject {
    
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
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    @Injected private var networkService: SWAPIServiceProtocol?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: StarshipModel
    
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
    }
    
    // MARK: - Network methods
    
    func fetchStarship() {
        loadState = .loading
        networkService?
            .fetchItem(urlString: urlStringToFetch)
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
    
    private func didReceive(item: Starship) {
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
