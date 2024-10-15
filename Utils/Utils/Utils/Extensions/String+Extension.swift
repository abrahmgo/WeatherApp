//
//  String+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
}
