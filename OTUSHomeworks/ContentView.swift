//
//  ContentView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresenting = false
    @State private var tabSelection = 0
    
    var body: some View {
        // 1. Добавить TabView
        TabView(selection: $tabSelection) {
            VStack {
                // 5. На первом табе должна быть кнопка открывающая второй таб и один из пунктов там
                Button("Press me!") {
                    isPresenting.toggle()
                    tabSelection = 1
                }
                .padding(.bottom)
                // 7. Добавить один UIKit компонент через UIViewRepresantable
                LabelView(content: .constant("Hello world from UIKit!")).frame(width: .infinity, height: 100, alignment: .center)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            // 2. На втором табе сделать List с обернутый в NavigationView
            NavigationViewScreen(isPresented: $isPresenting)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(1)
            ModalViewScreen()
                .font(.title)
                .tabItem {
                    Label("Modal", systemImage: "macwindow")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
