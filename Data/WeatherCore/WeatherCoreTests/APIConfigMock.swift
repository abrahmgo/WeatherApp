//
//  APIConfigMock.swift
//  WeatherCoreTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import NetoworkCore

struct APIConfigMock: NetworkCoreAPIConfigType {
    
    static var baseURL: String {
        return ""
    }
    
    static var useSampleData: Bool {
        return true
    }
    
    static var additionalHeaders: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    static var token: String {
        return "8ed946a39d01dfd229eeace4d13a0bd7"
    }
    
    static var language: String {
        
        return "es"
    }
}

