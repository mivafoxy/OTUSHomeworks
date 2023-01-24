//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.red.withAlphaComponent(0.2)
    }
    
    var body: some View {
        NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
            TabView {
                ListViewScreen<People>()
                ListViewScreen<Films>()
                ListViewScreen<Starships>()
                ListViewScreen<Vehicles>()
                ListViewScreen<Species>()
                ListViewScreen<Planets>()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
