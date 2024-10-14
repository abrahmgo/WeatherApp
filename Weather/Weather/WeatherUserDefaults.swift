//
//  WeatherUserDefaults.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

struct WeatherUserDefaults {
    
    static var defaults: UserDefaults? {
        return UserDefaults(suiteName: "WeatherUserDefaultsApp")
    }
    
    enum Keys: String {
        case firstLaunch
    }
    
    static var firstLaunch: Bool {
        set {
            defaults?.set(newValue, forKey: Keys.firstLaunch.rawValue)
            defaults?.synchronize()
        }
        
        get {
            return defaults?.value(forKey: Keys.firstLaunch.rawValue) as? Bool ?? false
        }
    }
}
