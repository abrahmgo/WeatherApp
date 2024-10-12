//
//  WeatherResponseModel+Mapper.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities

extension WeatherResponseModel {
    
    func mapToWeather() -> Weather {
        return Weather(information: weather.map({$0.mapToInformation()}),
                       temperature: main.mapToTemperature(),
                       name: name,
                       id: id,
                       timezone: timezone)
    }
}

extension WeatherInformation {
    
    func mapToInformation() -> WeatherEntities.WeatherInformation {
        return WeatherEntities.WeatherInformation(id: id,
                                                  main: main,
                                                  description: description,
                                                  icon: icon)
    }
}

extension WeatherTemperature {
    
    func mapToTemperature() -> WeatherEntities.WeatherTemperature {
        return WeatherEntities.WeatherTemperature(temp: temp,
                                                  feelsLike: feels_like,
                                                  tempMin: temp_min,
                                                  tempMax: temp_max,
                                                  pressure: pressure,
                                                  humidity: humidity,
                                                  seaLevel: sea_level,
                                                  grndLevel: grnd_level)
    }
}
