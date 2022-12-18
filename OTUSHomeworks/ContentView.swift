//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0
    
    
    var body: some View {
        VStack {
            Button("Press me!") {
                let viewModel = PeopleViewModel()
                viewModel.loadPeople()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
