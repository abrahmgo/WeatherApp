//
//  WeatherRequest.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public struct WeatherRequest {
    
    public let coordinates: WeatherCoordinates
    public let units: WeatherUnits
    
    public init(coordinates: WeatherCoordinates,
                units: WeatherUnits = .metric) {
        self.coordinates = coordinates
        self.units = units
    }
}
