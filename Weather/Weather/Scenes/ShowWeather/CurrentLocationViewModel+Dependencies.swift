//
//  CurrentLocationViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUsecases
import CoreLocation

protocol ShowWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ShowWeatherComponents], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
}

protocol ShowWeatherViewModelInputs { }

protocol ShowWeatherViewModelType {
    var outputs: ShowWeatherViewModelOutputs { get }
    var inputs: ShowWeatherViewModelInputs { get }
}

struct ShowWeatherDependencies {
    
    let coordinates: CLLocation
    let getAddressByCoordinates: GetAddressByCoordinatesUseCaseType
    let getWeather: GetWeatherUsecaseType
}
