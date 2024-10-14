//
//  LocalizableService.swift
//  Localizable
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

public struct LocalizableService {
    
    public static var shared: LocalizableService!
    
    private let language: LocalizableLanguage
    
    public init(language: LocalizableLanguage) {
        self.language = language
    }
    
    func get(key: String) -> String {
        
        switch language {
        case .es:
            return getNSLocalizedString(key: key, tableName: "Espanol")
        case .en:
            return getNSLocalizedString(key: key, tableName: "English")
        }
    }
    
    private func getNSLocalizedString(key: String, tableName: String) -> String {
        guard let bundle = Bundle(identifier: "com.andres.Localizable") else {
            return ""
        }
        return NSLocalizedString(key,
                                 tableName: tableName,
                                 bundle: bundle,
                                 value: "",
                                 comment: "")
    }
}

public enum LocalizableLanguage: String {
    case es
    case en
}
