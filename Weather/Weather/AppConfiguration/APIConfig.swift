//
//  APIConfig.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import NetoworkCore
import Localizable

struct APIConfig: NetworkCoreAPIConfigType {
    
    static var baseURL: String {
        #if DEBUG
        
        guard let serverInUse = UserDefaults.standard.object(forKey: "ServerInUse") as? String else {
            return APIBundle.development.server
        }
        
        guard let bundleAPI = APIBundle(rawValue: serverInUse) else {
            return APIBundle.development.server
        }
        
        return bundleAPI.server
        
        #else
        return APIBundle.production.server
        
        #endif
    }
    
    static var useSampleData: Bool {
        #if DEBUG
        return false
        #else
        return false
        #endif
    }
    
    static var additionalHeaders: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    static var token: String {
        return "8ed946a39d01dfd229eeace4d13a0bd7"
    }
    
    static var language: String {
        
        guard let serverInUse = UserDefaults.standard.object(forKey: "LanguageInUse") as? String else {
            return LanguageBundle.en.rawValue
        }
        
        guard let languageBundle = LanguageBundle(rawValue: serverInUse) else {
            return LanguageBundle.en.rawValue
        }
        
        return languageBundle.rawValue
    }
}
