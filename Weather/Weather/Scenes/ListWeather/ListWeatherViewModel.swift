//
//  ListWeatherViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherEntities
import CoreLocation
import WeatherUI

class ListWeatherViewModel: ListWeatherViewModelType, ListWeatherViewModelInputs, ListWeatherViewModelOutputs {

    // MARK: Properties
    var outputs: ListWeatherViewModelOutputs { return self }
    var inputs: ListWeatherViewModelInputs { return self }
    
    // MARK: Inputs
    
    // MARK: Outputs
    // MARK: Outputs
    var components: CurrentValueSubject<[ListWeatherComponent], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    // MARK: Private
    private let dependencies: ListWeatherDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(dependencies: ListWeatherDependencies) {
        self.dependencies = dependencies
    }
    
    func addNewCity(location: CLLocation) {
        Task {
            do {
                let coordinates = WeatherCoordinates(latitude: location.coordinate.latitude,
                                                     longitude: location.coordinate.longitude)
                let weather = try await dependencies.getWeather.execute(coordinates: coordinates)
                let address = try await dependencies.getAddress.execute(coordinates: location.coordinate)
                
                let data = CityWeatherViewCellData(title: address.city,
                                                   subtitle: "",
                                                   description: weather.information.first?.description ?? "",
                                                   temperature: "\(weather.temperature.temp.toInt())º",
                                                   minmax: "Maxima: \(weather.temperature.tempMax.toInt())º Minima: \(weather.temperature.tempMin.toInt())º")
                let component = ListWeatherComponent.city(data: data)
                let newComponents = components.value + [component]
                components.send(newComponents)
            } catch {
                
            }
        }
    }
}
