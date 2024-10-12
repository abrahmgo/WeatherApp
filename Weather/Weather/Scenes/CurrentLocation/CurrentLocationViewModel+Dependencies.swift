//
//  CurrentLocationViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUsecases
import WeatherEntities

protocol CurrentLocationViewModelOutputs {
    var components: CurrentValueSubject<[CurrentLocationComponents], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
}

protocol CurrentLocationViewModelInputs { }

protocol CurrentLocationViewModelType {
    var outputs: CurrentLocationViewModelOutputs { get }
    var inputs: CurrentLocationViewModelInputs { get }
}

struct CurrentLocationDependencies {
    let startLocation: StarLocalizationUseCaseType
    let getCurrentLocation: GetCurrentLocationUseCaseType
    let getAddressByCoordinates: GetAddressByCoordinatesUseCaseType
    let getWeather: GetWeatherUsecaseType
}
