//
//  PeopleViewModel.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

import Combine
import SwiftUI

final class PeopleViewModel: ObservableObject {
    var anyCancellables = Set<AnyCancellable>()
    
    func loadPeople() {
        SWAPI
            .shared
            .fetchPeoplePage(pageNumber: 1)
            .sink(receiveCompletion: didReceiveError(_:), receiveValue: didReceive(_:))
            .store(in: &anyCancellables)
    }
    
    private func didReceiveError(_ completion: Subscribers.Completion<Error>) {
        print(completion)
    }
    
    private func didReceive(_ people: People) {
        print(people)
    }
}
