//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

/*
 Уровень Core сервисов вынесен в пакет SWAPICore
 В него вошли сервисы по работе с сетью и ServiceLocator.
 */

struct ContentView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.red.withAlphaComponent(0.2)
        Configurator.shared.setup()
    }
    
    var body: some View {
            TabView {
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
                    ListViewScreen<People>()
                }
                
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
                    ListViewScreen<Films>()
                }
                
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
                    ListViewScreen<Starships>()
                }
                
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
                    ListViewScreen<Vehicles>()
                }
                
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
                    ListViewScreen<Species>()
                }
                
                NavigationStackView(transition: .custom(push: .scale, pop: .scale)) {
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
