//
//  ViewMapper.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI
import SWAPICore

protocol ViewMapperServiceProtocol {
    func makeView(from item: any ModelProtocol) -> any View
}

final class ViewMapperService: ViewMapperServiceProtocol {
    
    func makeView(from item: any ModelProtocol) -> any View {
        if let film = item as? Film {
            return FilmViewScreen(film)
        }
        
        return EmptyView()
    }
}
