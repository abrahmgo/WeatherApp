//
//  CurrentLocationViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUsecases
import CoreLocation
import WeatherEntities

protocol ShowWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ShowWeatherComponents], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
    var isNotificationActive: CurrentValueSubject<Bool, Never> { get }
    
    func getCoordinates() -> CLLocation
    func featureUse() -> ShowWeatherUse
}

protocol ShowWeatherViewModelInputs {
    func pressNotification()
}

protocol ShowWeatherViewModelType {
    var outputs: ShowWeatherViewModelOutputs { get }
    var inputs: ShowWeatherViewModelInputs { get }
}

struct ShowWeatherDependencies {
    
    let localWeather: LocalWeather
    let getAddressByCoordinates: GetAddressByCoordinatesUseCaseType
    let getWeather: GetWeatherUsecaseType
    let featureUse: ShowWeatherUse
    let downloadIcon: GetWeatherIconUsecaseType
    let updateObject: UpdateLocalObjectUsecaseType
    let setNotification: ScheduleLocalNotificationUsecaseType
    let removeNotification: RemoveLocalNotificationUsecaseType
}
