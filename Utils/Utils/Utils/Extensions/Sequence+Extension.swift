//
//  Sequence+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import Foundation

public extension Sequence {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
}
