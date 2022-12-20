//
//  PeopleListView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import SwiftUI

struct ListViewScreen<ModelType: Decodable & ListModelProtocol>: View {
    @State private var isActionSheetPresented = false
    @ObservedObject var viewModel = ListViewModel<ModelType>()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    
    var body: some View {
        switch viewModel.loadingState {
        case .idle:
            Color.clear.onAppear {
                viewModel.fetchItems()
            }
        case .loading:
            ProgressView("Загрузка...")
        case .finished, .subloading:
            List {
                ForEach(viewModel.model.items) { modelItem in
                    Text(modelItem.modelName)
                        .onAppear {
                            if viewModel.isLast(item: modelItem) {
                                viewModel.fetchItems()
                            }
                        }
                    
                    if viewModel.model.hasNextPage && viewModel.isLast(item:modelItem) {
                        ProgressView("Загрузка элементов")
                            .frame(idealWidth: .infinity,
                                   maxWidth: .infinity,
                                   alignment: .center)
                    }
                }
            }
        case .error:
            Button("Error, try again") {
                viewModel.fetchItems()
            }
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        ListViewScreen<People>()
    }
}
