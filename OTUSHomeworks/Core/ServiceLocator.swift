//
//  ServiceLocator.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 24.01.2023.
//

import Foundation

protocol ServiceLocating {
    func getService<T>() -> T?
}

final class ServiceLocator: ServiceLocating {
    private lazy var services: [String : Any] = [:]
    public static let shared = ServiceLocator()
    
    private init() {}
    
    func addService<T>(service: T) {
        let key = getTypeName(T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = getTypeName(T.self)
        return services[key] as? T
    }
    
    private func getTypeName(_ someType: Any) -> String {
        (someType is Any.Type) ? "\(someType)" : "\(type(of: someType))"
    }
}

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    
    public var wrappedValue: Service? {
        mutating get {
            if service == nil {
                service = ServiceLocator.shared.getService()
            }
            return service
        }
    }
    
    public var projectedValue: Injected<Service> {
        mutating set {
            self = newValue
        }
        get {
            return self
        }
    }
}
