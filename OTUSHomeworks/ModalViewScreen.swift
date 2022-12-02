//
//  ModalViewScreen.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI

struct ModalViewScreen: View {
    @State private var isModalPresented = false
    
    var body: some View {
        //4. На третьем табе должна быть кнопка открывающая модальное окно
        Button("Show modal view") {
            isModalPresented.toggle()
        }
        .sheet(isPresented: $isModalPresented) {
            VStack {
                Text("Hello world from modal!")
                Button("Dismiss") {
                    isModalPresented.toggle()
                }
            }
        }
        
    }
}

struct ModalViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ModalViewScreen()
    }
}
