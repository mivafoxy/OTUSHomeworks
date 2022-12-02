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
        TabView(selection: $tabSelection) {
            VStack {
                Button("Press me!") {
                    isPresenting.toggle()
                    tabSelection = 1
                }
                .padding(.bottom)
                
                LabelView(content: .constant("Hello world from UIKit!")).frame(width: .infinity, height: 100, alignment: .center)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
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
