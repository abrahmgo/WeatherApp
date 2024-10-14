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
import WeatherEntities

protocol ListWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ListWeatherComponent], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var locationError: PassthroughSubject<Error, Never> { get }
    
    func getWeather(index: Int) -> LocalWeather
    func featureUse(index: Int) -> ShowWeatherUse
    func featureUse(location: CLLocation) -> ShowWeatherUse
    func isError() -> Bool
}

protocol ListWeatherViewModelInputs {
    func addNewCity(location: CLLocation)
    func deleteCity(index: Int)
    func updateDB()
    func initFeature()
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
    let currentLocationStatus: GetCurrentLocationStatusUsecaseType
}
