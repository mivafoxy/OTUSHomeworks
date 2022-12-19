//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { g in
            ScrollView(.horizontal) {
                HStack {
                    ListViewScreen<People>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    ListViewScreen<Films>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    ListViewScreen<Starships>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    ListViewScreen<Vehicles>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    ListViewScreen<Species>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    ListViewScreen<Planets>()
                        .frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
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
