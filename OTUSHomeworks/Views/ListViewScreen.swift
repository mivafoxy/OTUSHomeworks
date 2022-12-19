//
//  PeopleListView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

import SwiftUI

struct ListViewScreen<ModelType: Decodable & ListModelProtocol>: View {
    @ObservedObject var viewModel = ListViewModel<ModelType>()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.model.items) { modelItem in
                Text(modelItem.modelName)
                    .onAppear {
                        if viewModel.model.items.isLastItem(modelItem) {
                            viewModel.fetchItems()
                        }
                    }
            }
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        ListViewScreen<People>()
    }
}
