//
//  WeatherCoordinates.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public struct WeatherCoordinates {
    
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
