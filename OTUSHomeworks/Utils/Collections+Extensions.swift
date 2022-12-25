//
//  Collections+Extensions.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 19.12.2022.
//

extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }

        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }

        let distance = self.distance(from: itemIndex, to: endIndex)

        return distance == 1
    }
}
