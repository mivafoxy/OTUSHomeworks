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
        viewModel = FilmStore(urlString: dataItem.url)
    }
    
    public init(_ urlString: String) {
        viewModel = FilmStore(urlString: urlString)
    }
    
    // MARK: - View
    
    var body: some View {
        switch viewModel.loadState {
        case .idle:
            Color.clear.onAppear {
                Task {
                    do {
                        // MARK: - 5. Чтение сделать в момент запуска приложения или перезахода в экран тестирования структуры данных
                        try await actionCreator.loadFromDisk(webUrl: viewModel.urlStringToFetch)
                    } catch {
                        actionCreator.fetch(with: viewModel.urlStringToFetch)
                    }
                }
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
                // MARK: - 4. Реализовать сохранение в файл при возвращении из экрана тестирования структуры данных
                Button("Назад") {
                    Task {
                        do {
                            try await actionCreator.saveToDisk(item: viewModel.model)
                        } catch {
                            fatalError("Failed to save film to disk")
                        }
                    }
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
            }
        }
    }
}

struct FilmViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
