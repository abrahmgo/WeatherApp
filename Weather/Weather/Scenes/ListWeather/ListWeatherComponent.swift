//
//  ListWeatherComponent.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherUI

public enum ListWeatherComponent { 
    case city(data: CityWeatherViewCellDataType)
    case footer(data: FooterViewCellDataType)
}
