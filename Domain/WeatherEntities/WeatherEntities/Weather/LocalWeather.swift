//
//  LocalWeather.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import CoreData
import Utils

public struct LocalWeather {
   
    public let id: Int
    public let latitude: Double
    public let longitude: Double
    public let notification: Bool
    public let registered: Date
    
    public init(id: Int, 
                latitude: Double,
                longitude: Double,
                notification: Bool = false,
                registered: Date = Date()) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.notification = notification
        self.registered = registered
    }
}
