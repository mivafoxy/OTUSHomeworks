//
//  ListViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import Combine
import Foundation

final class ListViewModel<ModelType: Decodable & ListModelProtocol>: ObservableObject {
    
    // MARK: - Types
    
    struct Model {
        var items = [ModelType.ElementsType]()
        var hasNextPage = true
        var currentPage = 1
    }
    
    enum State {
        case idle, loading, subloading, finished, error
    }
    
    // MARK: - Properties
    
    private let waitTimeInSec = 10
    private var anyCancellables = Set<AnyCancellable>()
    @Published private(set) var model = Model()
    @Published private(set) var loadingState = State.idle
    
    func fetchItems() {
        loadingState = model.items.isEmpty ? .loading : .subloading
        SWAPI
            .shared
            .fetchItemsPage(
                pageNumber: model.currentPage,
                sectionName: ModelType.sectionName)
            .timeout(.seconds(waitTimeInSec), scheduler: DispatchQueue.main)
            .sink(
                receiveCompletion: didReceiveError(_:),
                receiveValue: didReceive(_:))
            .store(in: &anyCancellables)
    }
    
    private func didReceiveError(_ completion: Subscribers.Completion<Error>) {
        guard case .finished = completion else { return }
        loadingState = .error
        model.hasNextPage = false
    }
    
    private func didReceive(_ item: ModelType) {
        model.items.append(contentsOf: item.elements)
        model.hasNextPage = item.hasNextElement
        model.currentPage += 1
        loadingState = .finished
    }
}
