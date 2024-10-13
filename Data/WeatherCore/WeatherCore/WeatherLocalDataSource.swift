//
//  WeatherLocalDataSource.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherDataSource

public struct WeatherLocalDataSource {
    
    public static var location: LocationServiceType {
        return LocationService()
    }
    
    public static var database: WeatherDBLocalDataSource {
        return CoreDataManager.shared
    }
}
