//
//  PeopleListView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import SwiftUI
import SWAPICore

struct ListViewScreen<ModelType: Decodable & ListModelProtocol>: View {
    
    // MARK: - Properties
    
    private var actionCreator = ListActionCreator<ModelType>()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    @ObservedObject var listStore = ListStore<ModelType>()
    
    // MARK: - View
    
    var body: some View {
        switch listStore.loadingState {
        case .idle:
            Color.clear.onAppear {
                actionCreator.callToFetchItemsPage(with: listStore.model.currentPage,
                                                   and: ModelType.sectionName)
            }
        case .loading:
            ProgressView("Загрузка...")
        case .finished, .subloading:
            List {
                ForEach(listStore.model.items) { modelItem in
                    Text(modelItem.modelName)
                        .onTapGesture {
                            guard
                                let view = listStore.getView(for: modelItem)
                            else {
                                return
                            }
                            navigation.push(newView: view)
                        }
                        .onAppear {
                            if listStore.isLast(item: modelItem) {
                                actionCreator.callToFetchItemsPage(with: listStore.model.currentPage,
                                                                   and: ModelType.sectionName)
                            }
                        }
                    
                    if listStore.model.hasNextPage && listStore.isLast(item:modelItem) {
                        ProgressView("Загрузка элементов")
                            .frame(idealWidth: .infinity,
                                   maxWidth: .infinity,
                                   alignment: .center)
                    }
                }
            }
        case .error:
            Button("Error, try again") {
                actionCreator.callToFetchItemsPage(with: listStore.model.currentPage,
                                                   and: ModelType.sectionName)
            }
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
