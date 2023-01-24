//
//  ListViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import Combine
import Foundation
import SwiftUI
import SWAPICore

final class ListViewModel<ModelType: Decodable & ListModelProtocol>: ObservableObject {
    
    // MARK: - Types
    
    struct Model {
        var items = [ModelType.ElementsType]()
        var hasNextPage = true
        var currentPage = 1
    }
    
    // MARK: - Properties
    
    private let waitTimeInSec = 60
    private var anyCancellables = Set<AnyCancellable>()
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var viewMapperService: ViewMapperServiceProtocol?
    @Injected private var networkService: SWAPIServiceProtocol?
    @Published private(set) var model = Model()
    @Published private(set) var loadingState = ViewModelLoadState.idle
    
    // MARK: - Business logic
    
    func getView(for item: ModelType.ElementsType) -> (any View)? {
        viewMapperService?.makeView(from: item)
    }
    
    // MARK: - Network handlers
    
    func fetchItems() {
        loadingState = model.items.isEmpty ? .loading : .subloading
        
        networkService?
            .fetchItemsPage(
                pageNumber: model.currentPage,
                sectionName: ModelType.sectionName)
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
    
    private func didReceiveError(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            loadingState = .finished
        case .failure:
            loadingState = .error
            model.hasNextPage = false
        }
    }
    
    private func didReceive(_ item: ModelType) {
        model.items.append(contentsOf: item.elements)
        model.hasNextPage = item.hasNextElement
        model.currentPage += 1
        loadingState = .finished
    }
    
    // MARK: - Helpers
    
    func isLast(item: ModelType.ElementsType) -> Bool {
        model.items.isLastItem(item)
    }
}
