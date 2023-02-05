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

final class ListStore<ModelType: Decodable & ListModelProtocol>: FluxStore {
    
    // MARK: - Types
    
    enum ListViewAction: FluxAction {
        case loaded(newItem: ModelType)
        case loadingFailure
        case loadingFinished
    }
    
    struct Model {
        var items = [ModelType.ElementsType]()
        var hasNextPage = true
        var currentPage = 1
    }
    
    // MARK: - Properties
    
    // 3. Добавить инжектинг в переменные инстанса класса,
    // чтобы в каждом классе можно было видеть зависимости, не скролля файл
    @Injected private var viewMapperService: ViewMapperServiceProtocol?
    @Injected private var appDispatcher: FluxDispatcher?
    @Published private(set) var model = Model()
    @Published private(set) var loadingState = ViewModelLoadState.idle
    
    // MARK: - Init
    
    init() {
        appDispatcher?.register(actionType: ListStore<ModelType>.ListViewAction.self, for: self)
    }
    
    // MARK: - FluxStore
    
    func onDispatch(with action: FluxAction) {
        guard
            let action = action as? ListStore<ModelType>.ListViewAction
        else {
            return
        }

        switch action {
        case let .loaded(newItem):
            didReceive(newItem)
        case .loadingFailure:
            loadingState = .error
            model.hasNextPage = false
        case .loadingFinished:
            loadingState = .finished
        }
    }
    
    private func didReceive(_ item: ModelType) {
        model.items.append(contentsOf: item.elements)
        model.hasNextPage = item.hasNextElement
        model.currentPage += 1
        loadingState = .finished
    }
    
    // MARK: - Business logic
    
    func getView(for item: ModelType.ElementsType) -> (any View)? {
        viewMapperService?.makeView(from: item)
    }
    
    // MARK: - Helpers
    
    func isLast(item: ModelType.ElementsType) -> Bool {
        model.items.isLastItem(item)
    }
}
