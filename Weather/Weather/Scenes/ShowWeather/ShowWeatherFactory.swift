//
//  CurrentLocationFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherUsecases
import WeatherCore
import WeatherEntities
import CoreLocation

struct ShowWeatherFactory {
    
    static func build(coordinates: CLLocation,
                      delegate: ShowWeatherDelegate? = nil,
                      isCurrentLocation: Bool = false) -> ShowWeatherViewController {
        
        let weatherService = WeatherRemoteDataSource.weather
        
        let getAddressByCoordinates = GetAddressByCoordinatesUseCase()
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherService)
        
        let dependencies = ShowWeatherDependencies(coordinates: coordinates,
                                                   getAddressByCoordinates: getAddressByCoordinates,
                                                   getWeather: getWeather, 
                                                   isCurrentLocation: isCurrentLocation)
        let viewModel = ShowWeatherViewModel(dependencies: dependencies)
        let view = ShowWeatherViewController(viewModel: viewModel, delegate: delegate)
        return view
    }
}
