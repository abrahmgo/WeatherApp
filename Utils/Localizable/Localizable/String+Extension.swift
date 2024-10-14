//
//  String+Extension.swift
//  Localizable
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

enum TableName: String {
    case es = "Espanol"
    case en = "English"
}

extension String {
    
    func localized(from tableName: TableName) -> String {
        
        guard let bundle = Bundle(identifier: "com.andres.Localizable") else {
            return ""
        }
        
        return NSLocalizedString(self, tableName: tableName.rawValue, bundle: bundle, value: "", comment: "")
    }
    
    func localized(from tableName: TableName, arguments: [String]) -> String {
        return String(format: self.localized(from: tableName), arguments: arguments)
    }
}
