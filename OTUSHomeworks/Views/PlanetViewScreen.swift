//
//  PlanetViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct PlanetViewScreen: View {
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: PlanetViewModel
    
    public init(_ dataItem: Planet) {
        viewModel = PlanetViewModel(from: dataItem)
    }
    
    public init(_ urlString: String) {
        viewModel = PlanetViewModel(urlString: urlString)
    }
    
    var body: some View {
        switch viewModel.loadState {
        case .idle:
            Color.clear.onAppear {
                viewModel.fetchPlanet()
            }
        case .loading:
            ProgressView("Загрузка...")
        case .finished:
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
        case .error:
            Button("Попробовать снова.") {
                viewModel.fetchPlanet()
            }
        case .subloading:
            EmptyView()
        }
    }
}

struct PlanetViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
