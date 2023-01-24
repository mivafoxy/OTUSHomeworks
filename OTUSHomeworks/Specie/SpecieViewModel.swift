//
//  SpecieViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

final class SpecieViewModel: ObservableObject {
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
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected var networkService: SWAPIServiceProtocol?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: SpecieModel
    
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
