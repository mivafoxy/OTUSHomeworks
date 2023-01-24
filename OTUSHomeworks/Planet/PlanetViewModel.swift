//
//  PlanetViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine

final class PlanetViewModel: ObservableObject {
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
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    @Injected var networkService: SWAPIServiceProtocol?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: PlanetModel
    
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
    }
    
    // MARK: - Network methods
    
    func fetchPlanet() {
        loadState = .loading
        networkService?
            .fetchItem(
                urlString: urlStringToFetch)
            .timeout(
                .seconds(waitTimeInSec),
                scheduler: DispatchQueue.main,
                customError: { SWAPIError.timeoutError })
            .sink(receiveCompletion: didReceive(completion:),
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
    
    private func didReceive(item: Planet) {
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
