//
//  APIBundle.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

enum APIBundle: String {
    
    case production = "PRODUCTION"
    case development = "DEV"
    
    var server: String {
        switch self {
        case .production:
            return "https://api.openweathermap.org/"
        case .development:
            return "https://api.openweathermap.org/"
        }
    }
}

