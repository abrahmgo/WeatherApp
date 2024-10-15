//
//  ListWeatherFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherUsecases
import WeatherCore

struct ListWeatherFactory {
    
    static func makeListWeather(coordinator: ListWeatherCoordinator) -> ListWeatherViewController {
        
        // MARK: RemoteDataSource
        let weatherService = WeatherRemoteDataSource.weather
        let locationService = WeatherLocalDataSource.location
        let iconService = WeatherRemoteDataSource.icon
        let localDB = WeatherLocalDataSource.database
        let geocoderSerivce = WeatherLocalDataSource.geocoder
        
        // MARK: Usecases
        
        let startLocation = StarLocalizationUseCase(locationService: locationService)
        let getCurrentLocation = GetCurrentLocationUseCase(locationService: locationService)
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherService)
        let getAddress = GetAddressByCoordinatesUseCase(geocoderService: geocoderSerivce)
        let downloadIcon = GetWeatherIconUsecase(remoteDataSource: iconService)
        let saveLocalWeather = SaveLocalObjectUsecase(localDB: localDB)
        let getLocalWeather = GetLocalObjectUsecase(localDB: localDB)
        let deleteLocalWeather = DeleteLocalObjectUsecase(localDB: localDB)
        let currentLocationStatus = GetCurrentLocationStatusUsecase(locationService: locationService)
        
        // MARK: ViewModel
        let dependencies = ListWeatherDependencies(getWeather: getWeather, 
                                                   getAddress: getAddress,
                                                   startLocation: startLocation,
                                                   getCurrentLocation: getCurrentLocation, 
                                                   downloadIcon: downloadIcon,
                                                   saveLocalWeather: saveLocalWeather,
                                                   getLocalWeather: getLocalWeather,
                                                   deleteLocalWeather: deleteLocalWeather,
                                                   currentLocationStatus: currentLocationStatus)
        
        let viewModel = ListWeatherViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = ListWeatherViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
