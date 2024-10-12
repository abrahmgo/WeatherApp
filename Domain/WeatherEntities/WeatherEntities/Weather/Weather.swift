//
//  Weather.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public struct Weather {
    
    public let information: [WeatherInformation]
    public let temperature: WeatherTemperature
    public let name: String
    public let id: Int
    public let timezone: Int
    
    public init(information: [WeatherInformation], 
                temperature: WeatherTemperature,
                name: String, id: Int, timezone: Int) {
        self.information = information
        self.temperature = temperature
        self.name = name
        self.id = id
        self.timezone = timezone
    }
}

public struct WeatherInformation {
    
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
    
    public init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

public struct WeatherTemperature {
    
    public let temp: Double
    public let feelsLike: Double
    public let tempMin: Double
    public let tempMax: Double
    public let pressure: Double
    public let humidity: Double
    public let seaLevel: Double
    public let grndLevel: Double
    
    public init(temp: Double, feelsLike: Double, 
                tempMin: Double, tempMax: Double,
                pressure: Double, humidity: Double,
                seaLevel: Double, grndLevel: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
}
