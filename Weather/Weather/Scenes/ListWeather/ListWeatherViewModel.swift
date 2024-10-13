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
import UIKit

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
    private var locations: [CLLocation] = []
    private var currentLocation: CLLocation?
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(dependencies: ListWeatherDependencies) {
        self.dependencies = dependencies
        
        setCurrentCity()
        setBinds()
    }
    
    func setBinds() {
        dependencies.getCurrentLocation.execute()
            .sink(receiveCompletion: { _ in }) { [weak self] location in
                guard let self = self else { return }
                Task {
                    do {
                        self.currentLocation = location
                        let component = try await self.getComponent(location: location, local: true)
                        self.components.send([component])
                    } catch {
                        
                    }
                }
            }.store(in: &cancellable)
    }
    
    func setCurrentCity() {
        Task {
            do {
                try await dependencies.startLocation.execute(type: .always)
            } catch {
                
            }
        }
    }
    
    func addNewCity(location: CLLocation) {
        Task {
            do {
                let component = try await getComponent(location: location)
                let newComponents = components.value + [component]
                components.send(newComponents)
            } catch {
                
            }
        }
    }
    
    func getComponent(location: CLLocation, local: Bool = false) async throws -> ListWeatherComponent {
        
        
        let coordinates = WeatherCoordinates(latitude: location.coordinate.latitude,
                                             longitude: location.coordinate.longitude)
        let weather = try await dependencies.getWeather.execute(coordinates: coordinates)
        let address = try await dependencies.getAddress.execute(coordinates: location.coordinate)
        locations.append(location)
        
        let imageData = try await dependencies.downloadIcon.execute(imageName: weather.information.first!.icon)
        let image = UIImage(data: imageData)
        
        let data = CityWeatherViewCellData(id: weather.id, title: address.city,
                                           subtitle: local ? "Mi ubicación" : "",
                                           description: weather.information.first?.description ?? "",
                                           temperature: "\(weather.temperature.temp.toInt())º",
                                           minmax: "Maxima: \(weather.temperature.tempMax.toInt())º Minima: \(weather.temperature.tempMin.toInt())º", 
                                           image: image)
        let component = ListWeatherComponent.city(data: data)
        
        return component
    }
    
    func getLocation(index: Int) -> CLLocation {
        return locations[index]
    }
    
    func isCurrentLocation(index: Int) -> Bool {
        guard let currentLocation = currentLocation else {
            return false
        }
        return locations[index] == currentLocation
    }
    
    func deleteCity(index: Int) {
        let object = components.value[index]
        guard case(.city(let data)) = object,
           let dataObject = data as? CityWeatherViewCellData else {
            return
        }
        
        let id = dataObject.id
        let newComponents = components.value.filter({ element in
            if case(.city(let data)) = element {
                if let dataObject = data as? CityWeatherViewCellData {
                    return id != dataObject.id
                } else {
                    return false
                }
            } else {
                return false
            }
        })
        
        components.send(newComponents)
    }
}
