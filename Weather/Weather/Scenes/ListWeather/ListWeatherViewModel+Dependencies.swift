//
//  ListWeatherViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import WeatherUsecases
import Combine
import CoreLocation

protocol ListWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ListWeatherComponent], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
    
    func getLocation(index: Int) -> CLLocation 
    func isCurrentLocation(index: Int) -> Bool
}

protocol ListWeatherViewModelInputs {
    func addNewCity(location: CLLocation)
}

protocol ListWeatherViewModelType {
    var outputs: ListWeatherViewModelOutputs { get }
    var inputs: ListWeatherViewModelInputs { get }
}

struct ListWeatherDependencies {
    
    let getWeather: GetWeatherUsecaseType
    let getAddress: GetAddressByCoordinatesUseCaseType
    let startLocation: StarLocalizationUseCaseType
    let getCurrentLocation: GetCurrentLocationUseCaseType
    let downloadIcon: GetWeatherIconUsecaseType
    let saveLocalWeather: SaveLocalObjectUsecaseType
    let getLocalWeather: GetLocalObjectUsecaseType
    let deleteLocalWeather: DeleteLocalObjectUsecaseType
}
