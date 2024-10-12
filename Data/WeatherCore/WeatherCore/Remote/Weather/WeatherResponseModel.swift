//
//  WeatherResponseModel.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

struct WeatherResponseModel: Decodable {
    let weather: [WeatherInformation]
    let base: String
    let main: WeatherTemperature
    let name: String
    let id: Int
    let cod: Int
    let timezone: Int
}

struct WeatherInformation: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherTemperature: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
    let sea_level: Double
    let grnd_level: Double
}
