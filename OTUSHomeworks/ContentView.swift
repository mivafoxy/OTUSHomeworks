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
            Picker(selection: $currentPage, label: Text("Section")) {
                Text("People").tag(0)
                Text("Planets").tag(1)
            }
            .pickerStyle(.segmented)
            
            if currentPage == 0 {
                ListViewScreen<People>()
            } else {
                ListViewScreen<Planets>()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
