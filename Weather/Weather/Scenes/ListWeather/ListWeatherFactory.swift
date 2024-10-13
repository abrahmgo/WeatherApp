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
        let weatherRemoteDataSource = WeatherRemoteDataSource.weather
        
        // MARK: Usecases
        
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherRemoteDataSource)
        let getAddress = GetAddressByCoordinatesUseCase()
        
        // MARK: ViewModel
        let dependencies = ListWeatherDependencies(getWeather: getWeather, getAddress: getAddress)
        let viewModel = ListWeatherViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = ListWeatherViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
