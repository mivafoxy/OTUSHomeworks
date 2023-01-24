//
//  ListModelProtocol.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

protocol ListModelProtocol: AnyObject {
    associatedtype ElementsType: ModelProtocol
    static var sectionName: String { get }
    var elements: [ElementsType] { get }
    var hasNextElement: Bool { get }
}
