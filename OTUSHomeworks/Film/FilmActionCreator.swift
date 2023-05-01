//
//  FilmActionCreator.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 26.02.2023.
//

import Combine
import Foundation
import SWAPICore

// MARK: - Types

enum FilmError: Error {
    case loadFromDiskError(message: String)
    case saveToDiskError(message: String)
}

final class FilmActionCreator {
    // MARK: - Properties

    // Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости,
    // не скролля файл
    private var anyCancellables: [AnyCancellable] = []
    @Injected private var dispatcher: FluxDispatcher?
    @Injected private var networkService: SWAPIServiceProtocol?

    // MARK: - Actions

    func fetch(with urlString: String) {
        let waitTimeInSec = 60
        networkService?
            .fetchItem(urlString: urlString)
            .timeout(
                .seconds(waitTimeInSec),
                scheduler: DispatchQueue.main,
                customError: { SWAPIError.timeoutError })
            .sink(
                receiveCompletion: didReceive(completion:),
                receiveValue: didReceive(item:))
            .store(in: &anyCancellables)
    }

    private func didReceive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            dispatcher?.dispatch(action: FilmAction.loaded(item: nil))
        case .failure:
            dispatcher?.dispatch(action: FilmAction.failure)
        }
    }
    
    private func didReceive(item: Film) {
        dispatcher?.dispatch(action: FilmAction.loaded(item: item))
    }
    
    // MARK: - 1. Реализовать кэширование на Realm/Files/Firebase/CoreData (лучше то, что еще не использовали)
    
    func loadFromDisk(webUrl: String) async throws {
        let task = Task<FilmStore.FilmModel?, Error> {
            let fileURL = try fileURL(webUrl: webUrl)
            guard let data = try? Data(contentsOf: fileURL) else {
                throw FilmError.loadFromDiskError(message: "Invalid file")
            }
            let film = try JSONDecoder().decode(FilmStore.FilmModel.self, from: data)
            return film
        }
        guard let film = try await task.value else {
            throw FilmError.loadFromDiskError(message: "Task returned nil")
        }
        dispatcher?.dispatch(action: FilmAction.loadedFromDisk(item: film))
    }
    
    func saveToDisk(item: FilmStore.FilmModel) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(item)
            let outfile = try fileURL(webUrl: item.url)
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func fileURL(webUrl: String) throws -> URL {
        let test = webUrl.replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ":", with: "")
        return try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(test)film.data")
    }
}
