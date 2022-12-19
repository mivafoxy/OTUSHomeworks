//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ListViewScreen<Species>()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
