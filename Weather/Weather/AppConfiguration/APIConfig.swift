//
//  APIConfig.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import NetoworkCore

struct APIConfig: NetworkCoreAPIConfigType {
    
    static var baseURL: String {
        #if DEBUG
        
        return APIBundle.development.server
        
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
        return ["":""]
    }
    
    static var token: String {
        return "8ed946a39d01dfd229eeace4d13a0bd7"
    }
}
