//
//  CurrentLocationFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherUsecases
import WeatherCore

struct CurrentLocationFactory {
    
    static func build() -> CurrentLocationViewController {
        
        let locationService = WeatherLocalDataSource.location
        let weatherService = WeatherRemoteDataSource.weather
        
        let startLocation = StarLocalizationUseCase(locationService: locationService)
        let getCurrentLocation = GetCurrentLocationUseCase(locationService: locationService)
        let getAddressByCoordinates = GetAddressByCoordinatesUseCase()
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherService)
        
        let dependencies = CurrentLocationDependencies(startLocation: startLocation,
                                                       getCurrentLocation: getCurrentLocation,
                                                       getAddressByCoordinates: getAddressByCoordinates,
                                                       getWeather: getWeather)
        let viewModel = CurrentLocationViewModel(dependencies: dependencies)
        let view = CurrentLocationViewController(viewModel: viewModel)
        return view
    }
}
