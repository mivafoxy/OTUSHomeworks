//
//  VehicleViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct VehicleViewScreen: View {
    
    // MARK: - Properties
    
    private let actionCreator = VehicleActionCreator()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var viewModel: VehicleStore
    
    // MARK: - Initializers
    
    init(_ item: Vehicle) {
        viewModel = VehicleStore(from: item)
    }
    
    init(_ urlString: String) {
        viewModel = VehicleStore(urlString: urlString)
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
        case .error, .subloading:
            Button("Попробовать снова.") {
                actionCreator.fetch(with: viewModel.urlStringToFetch)
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
                    Text("Вместимость: \(viewModel.model.cargoCapacity)")
                    Text("Топливо: \(viewModel.model.consumables)")
                    Text("Стоимость: \(viewModel.model.costInCredits)")
                    Text("Количество людей в составе: \(viewModel.model.crew)")
                    Text("Длина: \(viewModel.model.length)")
                    Text("Производитель: \(viewModel.model.manufacturer)")
                }
                
                Group {
                    Text("Максимальная скорость: \(viewModel.model.maxAtmospheringSpeed)")
                    Text("Модель: \(viewModel.model.model)")
                    Text("Наименование: \(viewModel.model.name)")
                    Text("Количество пассажиров: \(viewModel.model.passengers)")
                    Text("Класс: \(viewModel.model.vehicleClass)")
                }

                Group {
                    Text("Создан: \(viewModel.model.created)")
                    Text("Обновлен:  \(viewModel.model.edited)")
                }

                Group {
                    Text("Ссылки на фильмы:")
                    ForEach(viewModel.model.films, id: \.self) { filmUrl in
                        Button(filmUrl) {
                            navigation.push(newView: FilmViewScreen(filmUrl))
                        }
                    }
                    Text("Ссылки на пилотов:")
                    ForEach(viewModel.model.pilots, id: \.self) { pilotUrl in
                        Button(pilotUrl) {
                            navigation.push(newView: PersonViewScreen(pilotUrl))
                        }
                    }
                }
            }
        }
    }
}

struct VehicleViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
