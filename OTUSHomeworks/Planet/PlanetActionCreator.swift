//
//  PlanetActionCreator.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 26.02.2023.
//

import Combine
import Foundation
import SWAPICore

final class PlanetActionCreator {

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
            dispatcher?.dispatch(action: PlanetAction.loaded(item: nil))
        case .failure:
            dispatcher?.dispatch(action: PlanetAction.failure)
        }
    }
    
    private func didReceive(item: Planet) {
        dispatcher?.dispatch(action: PlanetAction.loaded(item: item))
    }
}
