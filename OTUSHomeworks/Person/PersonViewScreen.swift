//
//  PersonViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct PersonViewScreen: View {
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: PersonViewModel
    
    public init(_ dataItem: Person) {
        viewModel = PersonViewModel(from: dataItem)
    }
    
    public init(_ urlString: String) {
        viewModel = PersonViewModel(urlString: urlString)
    }
    
    var body: some View {
        switch viewModel.loadState {
        case .idle:
            Color.clear.onAppear {
                viewModel.fetchPerson()
            }
        case .loading:
            ProgressView("Загрузка...")
        case .finished:
            mainBody
        case .error, .subloading:
            Button("Попробовать снова.") {
                viewModel.fetchPerson()
            }
        }
    }
    
    var mainBody: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Button("Назад") {
                    navigation.pop()
                }
                Group {
                    Text("Имя: \(viewModel.model.name)")
                    Text("Дата рождения: \(viewModel.model.birthYear)")
                    Text("Цвет глаз: \(viewModel.model.eyeColor)")
                    Text("Пол: \(viewModel.model.gender)")
                    Text("Цвет волос: \(viewModel.model.hairColor)")
                    Text("Рост: \(viewModel.model.height)")
                    Text("Вес: \(viewModel.model.mass)")
                    Text("Цвет кожи: \(viewModel.model.skinColor)")
                }

                Group {
                    Text("Создан: \(viewModel.model.created)")
                    Text("Обновлен:  \(viewModel.model.edited)")
                }

                Button("Родина: \(viewModel.model.homeworld)") {
                    navigation.push(newView: PlanetViewScreen(viewModel.model.homeworld))
                }
                
                Group {
                    Text("Ссылки на фильмы:")
                    ForEach(viewModel.model.films, id: \.self) { filmUrl in
                        Button(filmUrl) {
                            navigation.push(newView: FilmViewScreen(filmUrl))
                        }
                    }
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
                }
            }
        }
    }
}

struct PersonViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
