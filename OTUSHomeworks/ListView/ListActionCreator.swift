//
//  ListActionCreator.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 05.02.2023.
//

import Combine
import Foundation
import SWAPICore

final class ListActionCreator<ModelType: Decodable & ListModelProtocol> {
    private var anyCancellables = Set<AnyCancellable>()
    @Injected var dispatcher: FluxDispatcher?
    @Injected var networkService: SWAPIServiceProtocol?
    
    func callToFetchItemsPage(with number: Int, and sectionName: String) {
        let waitTimeInSec = 60
        networkService?
            .fetchItemsPage(
                pageNumber: number,
                sectionName: sectionName)
            .timeout(
                .seconds(waitTimeInSec),
                scheduler: DispatchQueue.main,
                customError: { SWAPIError.timeoutError })
            .sink(
                receiveCompletion: didReceiveError(_:),
                receiveValue: didReceive(_:))
            .store(
                in: &anyCancellables)
    }
    
    private func didReceive(_ item: ModelType) {
        dispatcher?.dispatch(action: ListStore.ListViewAction.loaded(newItem: item))
    }
    
    private func didReceiveError(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            dispatcher?.dispatch(action: ListStore<ModelType>.ListViewAction.loadingFinished)
        case .failure:
            dispatcher?.dispatch(action: ListStore<ModelType>.ListViewAction.loadingFailure)
        }
    }
}
