//
//  SpecieViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct SpecieViewScreen: View {
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: SpecieViewModel
    
    public init(_ dataItem: Specie) {
        viewModel = SpecieViewModel(from: dataItem)
    }
    
    public init(_ urlString: String) {
        viewModel = SpecieViewModel(urlString: urlString)
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
                        Text("Название: \(viewModel.model.name)")
                        Text("Классификация: \(viewModel.model.classification)")
                        Text("Обозначение: \(viewModel.model.designation)")
                        Text("Средний рост: \(viewModel.model.averageHeight)")
                        Text("Средняя продолжительность жизни: \(viewModel.model.averageLifespan)")
                        Text("Цвет глаз: \(viewModel.model.eyeColors)")
                        Text("Цвет кожи: \(viewModel.model.skinColors)")
                        Text("Язык: \(viewModel.model.language)")
                        
                    }
                    
                    Button("Родной мир: \(viewModel.model.homeworld ?? "nil")") {
                        navigation.push(newView: PlanetViewScreen(viewModel.model.homeworld ?? ""))
                    }
                    
                    Group {
                        Text("Создан: \(viewModel.model.created)")
                        Text("Обновлен:  \(viewModel.model.edited)")
                    }
                    
                    Group {
                        Text("Ссылки на людей:")
                        ForEach(viewModel.model.people, id: \.self) { personUrl in
                            Button(personUrl) {
                                navigation.push(newView: PersonViewScreen(personUrl))
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

struct SpecieViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
