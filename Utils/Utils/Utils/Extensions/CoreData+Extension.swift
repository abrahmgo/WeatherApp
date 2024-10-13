//
//  CoreData+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
