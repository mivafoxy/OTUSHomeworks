//
//  OTUSHomeworksApp.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 30.11.2022.
//

import SwiftUI
import SWAPICore

@main
struct OTUSHomeworksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        setupViewMapperService()
        setupNetworkService()
    }
    
    private func setupViewMapperService() {
        let viewMapperService: ViewMapperServiceProtocol = ViewMapperService()
        ServiceLocator.shared.addService(service: viewMapperService)
    }
    
    private func setupNetworkService() {
        let networkService: SWAPIServiceProtocol = SWAPIService()
        ServiceLocator.shared.addService(service: networkService)
    }
}
