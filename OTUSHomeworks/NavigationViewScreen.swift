//
//  NavigationView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct NavigationViewScreen: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("First thing", isActive: $isPresented) {
                    Text("From first thing")
                }
                NavigationLink("Second thing") {
                    Text("From second thing")
                }
                NavigationLink("Third thing") {
                    Text("From third thing")
                }
                NavigationLink("Fourth thing") {
                    Text("From fourth thing")
                }
            }
        }
    }
}

struct NavigationViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewScreen(isPresented: .constant(false))
    }
}
