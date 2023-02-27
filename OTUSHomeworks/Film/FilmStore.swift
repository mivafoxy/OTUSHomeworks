//
//  FilmViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import Combine
import SWAPICore

enum FilmAction: FluxAction {
    case loaded(item: Film?)
    case failure
}

final class FilmStore: FluxStore {
    
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

    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var dispatcher: FluxDispatcher?
    @Published private(set) var loadState: ViewModelLoadState
    @Published private(set) var model: FilmModel
    let urlStringToFetch: String
    
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
        dispatcher?.register(actionType: FilmAction.self, for: self)
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
        dispatcher?.register(actionType: FilmAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? FilmAction
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

    private func didReceive(item: Film?) {
        guard let item = item else { return }
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
