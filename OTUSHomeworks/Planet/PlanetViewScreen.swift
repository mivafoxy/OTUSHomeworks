//
//  PlanetViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct PlanetViewScreen: View {
    
    // MARK: - Properties
    
    private let actionCreator = PlanetActionCreator()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: PlanetStore
    
    // MARK: - Initializers
    
    public init(_ dataItem: Planet) {
        viewModel = PlanetStore(from: dataItem)
    }
    
    public init(_ urlString: String) {
        viewModel = PlanetStore(urlString: urlString)
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
                    Text("Климат: \(viewModel.model.climate)")
                    Text("Диаметр: \(viewModel.model.diameter)")
                    Text("Гравитация: \(viewModel.model.gravity)")
                    Text("Название: \(viewModel.model.name)")
                    Text("Орбитальный период: \(viewModel.model.orbitalPeriod)")
                    Text("Население: \(viewModel.model.population)")
                    Text("Период вращения: \(viewModel.model.rotationPeriod)")
                    Text("Вода на поверхности: \(viewModel.model.surfaceWater)")
                    Text("Местность: \(viewModel.model.terrain)")
                }
                
                Group {
                    Text("Создан: \(viewModel.model.created)")
                    Text("Обновлен:  \(viewModel.model.edited)")
                }
                
                Group {
                    Text("Ссылки на граждан:")
                    ForEach(viewModel.model.residents, id: \.self) { residentUrl in
                        Button(residentUrl) {
                            navigation.push(newView: PersonViewScreen(residentUrl))
                        }
                    }
                    Text("Ссылки на фильмы:")
                    ForEach(viewModel.model.films, id: \.self) { filmUrl in
                        Button(filmUrl) {
                            navigation.push(newView: FilmViewScreen(filmUrl))
                        }
                    }
                }
            }
        }
    }
}

struct PlanetViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
