//
//  ListViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import Combine

final class ListViewModel<ModelType: Decodable & ListModelProtocol>: ObservableObject {
    
    // MARK: - Types
    
    struct Model {
        var items = [ModelType.ElementsType]()
        var hasNextPage = true
        var currentPage = 1
    }
    
    // MARK: - Properties
    
    private var anyCancellables = Set<AnyCancellable>()
    @Published private(set) var model = Model()
    
    func fetchItems() {
        SWAPI
            .shared
            .fetchItemsPage(
                pageNumber: model.currentPage,
                sectionName: ModelType.sectionName)
            .sink(
                receiveCompletion: didReceiveError(_:),
                receiveValue: didReceive(_:))
            .store(in: &anyCancellables)
    }
    
    private func didReceiveError(_ completion: Subscribers.Completion<Error>) {
        if case let .failure(error) = completion {
            print(error)
            model.hasNextPage = false
        }
    }
    
    private func didReceive(_ item: ModelType) {
        model.items.append(contentsOf: item.elements)
        model.hasNextPage = item.hasNextElement
        model.currentPage += 1
    }
}
