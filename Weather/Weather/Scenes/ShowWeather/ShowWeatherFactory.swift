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
    
    static func build(localWeather: LocalWeather,
                      delegate: ShowWeatherDelegate? = nil,
                      featureUse: ShowWeatherUse = .read) -> ShowWeatherViewController {
        
        let weatherService = WeatherRemoteDataSource.weather
        let iconService = WeatherRemoteDataSource.icon
        let localDB = WeatherLocalDataSource.database
        
        let getAddressByCoordinates = GetAddressByCoordinatesUseCase()
        let getWeather = GetWeatherUsecase(remoteDataSource: weatherService)
        let updateObject = UpdateLocalObjectUsecase(localDB: localDB)
        let downloadIcon = GetWeatherIconUsecase(remoteDataSource: iconService)
        let setNotification = ScheduleLocalNotificationUsecase()
        let removeNotification = RemoveLocalNotificationUsecase()
        
        let dependencies = ShowWeatherDependencies(localWeather: localWeather,
                                                   getAddressByCoordinates: getAddressByCoordinates,
                                                   getWeather: getWeather, 
                                                   featureUse: featureUse,
                                                   downloadIcon: downloadIcon, 
                                                   updateObject: updateObject,
                                                   setNotification: setNotification, 
                                                   removeNotification: removeNotification)
        let viewModel = ShowWeatherViewModel(dependencies: dependencies)
        let view = ShowWeatherViewController(viewModel: viewModel, delegate: delegate)
        return view
    }
}
