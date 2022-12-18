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
        HStack {
            VStack {
                Picker("Segmented Picker", selection: $currentPage) {
                    Text("Москва")
                        .tag(0)
                    Text("Cанкт-Петербург")
                        .tag(1)
                    Text("Воронеж")
                        .tag(2)
                }
                .pickerStyle(.segmented)
                List {
                    Text("Hello")
                    Text("bye")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
