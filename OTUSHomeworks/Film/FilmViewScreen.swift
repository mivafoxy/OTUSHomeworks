//
//  FilmViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct FilmViewScreen: View {
    
    // MARK: - Properties
    
    private let actionCreator = FilmActionCreator()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: FilmStore
    
    // MARK: - Inits
    
    public init(_ dataItem: Film) {
        viewModel = FilmStore(from: dataItem)
    }
    
    public init(_ urlString: String) {
        viewModel = FilmStore(urlString: urlString)
    }
    
    // MARK: - View
    
    var body: some View {
        switch viewModel.loadState {
        case .idle:
            Color.clear.onAppear {
                actionCreator.fetch(with: viewModel.urlStringToFetch)
            }
        case .loading:
            ProgressView("Загрузка...")
        case .finished:
            mainBody
        case .error:
            Button("Попробовать снова.") {
                actionCreator.fetch(with: viewModel.urlStringToFetch)
            }
        case .subloading:
            EmptyView()
        }
    }
    
    var mainBody: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Button("Назад") {
                    navigation.pop()
                }
                Group {
                    Text("Название: \(viewModel.model.title)")
                    Text("Номер эпизода: \(viewModel.model.episodeId)")
                    Text("Текст субтритров: \(viewModel.model.openingCrawl)")
                    Text("Режиссер: \(viewModel.model.director)")
                    Text("Продюсер: \(viewModel.model.producer)")
                    Text("Дата выхода: \(viewModel.model.releaseDate)")
                }
                
                Group {
                    Text("Создан: \(viewModel.model.created)")
                    Text("Обновлен:  \(viewModel.model.edited)")
                }
                
                Group {
                    Text("Ссылки на корабли:")
                    ForEach(viewModel.model.starships, id: \.self) { starshipUrl in
                        Button(starshipUrl) {
                            navigation.push(newView: StarshipViewScreen(starshipUrl))
                        }
                    }
                    Text("Ссылки на наземный транспорт:")
                    ForEach(viewModel.model.vehicles, id: \.self) { vehicleUrl in
                        Button(vehicleUrl) {
                            navigation.push(newView: VehicleViewScreen(vehicleUrl))
                        }
                    }
                    Text("Ссылки на расы:")
                    ForEach(viewModel.model.species, id: \.self) { specieUrl in
                        Button(specieUrl) {
                            navigation.push(newView: SpecieViewScreen(specieUrl))
                        }
                    }
                    Text("Ссылки на персонажей:")
                    ForEach(viewModel.model.characters, id: \.self) { filmUrl in
                        Button(filmUrl) {
                            navigation.push(newView: PersonViewScreen(filmUrl))
                        }
                    }
                    Text("Ссылки на планеты:")
                    ForEach(viewModel.model.planets, id: \.self) { planetUrl in
                        Button(planetUrl) {
                            navigation.push(newView: PlanetViewScreen(planetUrl))
                        }
                    }
                }
            }
        }
    }
}

struct FilmViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
