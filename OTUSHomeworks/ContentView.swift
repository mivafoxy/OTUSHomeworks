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
        TabView {
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<People>()
            }
            
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<Films>()
            }
             
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<Starships>()
            }
            
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<Vehicles>()
            }
            
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<Species>()
            }
            
            NavigationStackView(transition: .custom(push: .slide, pop: .slide)) {
                ListViewScreen<Planets>()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
