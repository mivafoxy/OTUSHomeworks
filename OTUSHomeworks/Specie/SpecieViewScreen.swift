//
//  SpecieViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

struct SpecieViewScreen: View {
    
    // MARK: - Properties
    
    private var specieActionCreator = SpecieActionCreator()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject private var store: SpecieStore
    
    // MARK: - Init
    
    public init(_ dataItem: Specie) {
        store = SpecieStore(from: dataItem)
    }
    
    public init(_ urlString: String) {
        store = SpecieStore(urlString: urlString)
    }
    
    // MARK: - View
    
    var body: some View {
        switch store.loadState {
        case .idle:
            Color.clear.onAppear {
                specieActionCreator.fetch(with: store.urlStringToFetch)
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
                        Text("Название: \(store.model.name)")
                        Text("Классификация: \(store.model.classification)")
                        Text("Обозначение: \(store.model.designation)")
                        Text("Средний рост: \(store.model.averageHeight)")
                        Text("Средняя продолжительность жизни: \(store.model.averageLifespan)")
                        Text("Цвет глаз: \(store.model.eyeColors)")
                        Text("Цвет кожи: \(store.model.skinColors)")
                        Text("Язык: \(store.model.language)")
                        
                    }
                    
                    Button("Родной мир: \(store.model.homeworld ?? "nil")") {
                        navigation.push(newView: PlanetViewScreen(store.model.homeworld ?? ""))
                    }
                    
                    Group {
                        Text("Создан: \(store.model.created)")
                        Text("Обновлен:  \(store.model.edited)")
                    }
                    
                    Group {
                        Text("Ссылки на людей:")
                        ForEach(store.model.people, id: \.self) { personUrl in
                            Button(personUrl) {
                                navigation.push(newView: PersonViewScreen(personUrl))
                            }
                        }
                        Text("Ссылки на фильмы:")
                        ForEach(store.model.films, id: \.self) { filmUrl in
                            Button(filmUrl) {
                                navigation.push(newView: FilmViewScreen(filmUrl))
                            }
                        }
                    }
                }
            }
        case .error:
            Button("Попробовать снова.") {
                specieActionCreator.fetch(with: store.urlStringToFetch)
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
