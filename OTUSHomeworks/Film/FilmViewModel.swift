//
//  FilmViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine

final class FilmViewModel: ObservableObject {
    
    // MARK: - Types
    
    struct FilmModel {
        let title: String
        let episodeId: Int
        let openingCrawl: String
        let director: String
        let producer: String
        let releaseDate: String
        let species: [String]
        let starships: [String]
        let vehicles: [String]
        let characters: [String]
        let planets: [String]
        let url: String
        let created: String
        let edited: String
    }
    
    // MARK: - Properties
    
    private let urlStringToFetch: String
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    @Injected var networkService: SWAPIServiceProtocol?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: FilmModel
    
    // MARK: - Init
    
    init(from item: Film) {
        loadState = .finished
        model = FilmModel(title: item.title,
                          episodeId: item.episode_id,
                          openingCrawl: item.opening_crawl,
                          director: item.director,
                          producer: item.producer,
                          releaseDate: item.release_date,
                          species: item.species,
                          starships: item.starships,
                          vehicles: item.vehicles,
                          characters: item.characters,
                          planets: item.planets,
                          url: item.url,
                          created: item.created,
                          edited: item.edited)
        urlStringToFetch = item.url
    }
    
    init(urlString: String) {
        loadState = .idle
        model = FilmModel(title: "",
                          episodeId: -1,
                          openingCrawl: "",
                          director: "",
                          producer: "",
                          releaseDate: "",
                          species: [],
                          starships: [],
                          vehicles: [],
                          characters: [],
                          planets: [],
                          url: "",
                          created: "",
                          edited: "")
        urlStringToFetch = urlString
    }
    
    // MARK: - Network Methods
    
    func fetchFilm() {
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
    
    private func didReceive(item: Film) {
        loadState = .finished
        model = FilmModel(title: item.title,
                          episodeId: item.episode_id,
                          openingCrawl: item.opening_crawl,
                          director: item.director,
                          producer: item.producer,
                          releaseDate: item.release_date,
                          species: item.species,
                          starships: item.starships,
                          vehicles: item.vehicles,
                          characters: item.characters,
                          planets: item.planets,
                          url: item.url,
                          created: item.created,
                          edited: item.edited)
    }
}
