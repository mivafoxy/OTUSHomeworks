//
//  ViewMapper.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 20.12.2022.
//

import SwiftUI

final class ViewMapper {
    
    static func makeView(from item: any ModelProtocol) -> any View {
        if let person = item as? Person {
            return PersonViewScreen(person)
        } else if let film = item as? Film {
            return FilmViewScreen(film)
        } else if let starship = item as? Starship {
            return StarshipViewScreen(starship)
        } else if let planet = item as? Planet {
            return PlanetViewScreen(planet)
        } else if let vehicle = item as? Vehicle {
            return VehicleViewScreen(vehicle)
        } else if let specie = item as? Specie {
            return SpecieViewScreen(specie)
        }
        
        return EmptyView()
    }
}
