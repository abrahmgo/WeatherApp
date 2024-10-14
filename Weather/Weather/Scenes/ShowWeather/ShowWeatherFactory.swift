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
                      featureUse: ShowWeatherUse = .read) -> ShowWeatherViewController {
        
        let weatherService = WeatherRemoteDataSource.weather
        let iconService = WeatherRemoteDataSource.icon
        
        let getAddressByCoordinates = GetAddressByCoordinatesUseCase()
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherService)
        let downloadIcon = GetWeatherIconUsecase(remoteDataSource: iconService)
        
        let dependencies = ShowWeatherDependencies(coordinates: coordinates,
                                                   getAddressByCoordinates: getAddressByCoordinates,
                                                   getWeather: getWeather, 
                                                   featureUse: featureUse,
                                                   downloadIcon: downloadIcon)
        let viewModel = ShowWeatherViewModel(dependencies: dependencies)
        let view = ShowWeatherViewController(viewModel: viewModel, delegate: delegate)
        return view
    }
}
