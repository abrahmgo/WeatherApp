//
//  WeatherRequest.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public struct WeatherRequest {
    
    public let coordinates: WeatherCoordinates
    
    public init(coordinates: WeatherCoordinates) {
        self.coordinates = coordinates
    }
}
