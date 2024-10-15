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
import Localizable

class ListWeatherViewModel: ListWeatherViewModelType, ListWeatherViewModelInputs, ListWeatherViewModelOutputs {

    // MARK: Properties
    var outputs: ListWeatherViewModelOutputs { return self }
    var inputs: ListWeatherViewModelInputs { return self }
    
    // MARK: Inputs
    
    // MARK: Outputs
    // MARK: Outputs
    var components: CurrentValueSubject<[ListWeatherComponent], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var locationError: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    // MARK: Private
    private let dependencies: ListWeatherDependencies
    private var locations: [CLLocation] = []
    private var localWeathers: [LocalWeather] = []
    private var currentLocation: CLLocation?
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var haveError = false
    private var initLocation = false
    
    init(dependencies: ListWeatherDependencies) {
        self.dependencies = dependencies
        
        setCurrentCity()
        setBinds()
    }
    
    func initFeature() {
        setCurrentCity()
    }
    
    func setBinds() {
        dependencies.getCurrentLocation.execute()
            .sink(receiveCompletion: { _ in
                self.initLocation = false
            }) { [weak self] location in
                guard let self = self else { return }
                self.setCities(currentLocation: location)
            }.store(in: &cancellable)
        
        dependencies.currentLocationStatus.execute()
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    if !self.initLocation {
                        self.setCurrentCity()
                    }
                default:
                    self.locationError.send(WeatherError.LocationRequestService)
                }
            }.store(in: &cancellable)
    }
    
    func setCities(currentLocation: CLLocation) {
        Task {
            do {
                haveError = false
                self.currentLocation = currentLocation
                let weather = try await self.getWeather(location: currentLocation)
                let address = try await self.getAddress(coordinates: currentLocation.coordinate)
                let component = try await self.getComponent(location: currentLocation,
                                                            weather: weather,
                                                            local: true, 
                                                            address: address)
                self.components.send([component])
                try await self.setLocalWeather()
            } catch {
                haveError = true
                self.locationError.send(WeatherError.LocationRequestService)
            }
        }
    }
    
    func setCurrentCity() {
        Task {
            do {
                try await dependencies.startLocation.execute(type: .always)
                self.initLocation = true
            } catch {
                self.initLocation = false
                self.currentLocation = nil
                self.components.send([])
                self.locations.removeAll()
                self.localWeathers.removeAll()
                try await setLocalWeather()
            }
        }
    }
    
    func addNewCity(location: CLLocation) {
        Task {
            do {
                let weather = try await getWeather(location: location)
                if try await !isPreviusSaved(id: weather.id) {
                    let address = try await getAddress(coordinates: location.coordinate)
                    let component = try await getComponent(location: location, weather: weather, address: address)
                    try await saveLocalWeather(coordinates: location, weather: weather, address: address)
                    let newComponents = components.value + [component]
                    components.send(newComponents)
                    updateDB()
                }
            } catch {
                
            }
        }
    }
    
    private func getLocalComponents() async throws -> [ListWeatherComponent] {
        let objects = try await dependencies.getLocalWeather.execute()
        let components = objects.map({ getLocalComponent(data: $0 )})
        return components
    }
    
    private func getLocalComponent(data: LocalWeather) -> ListWeatherComponent {
        let data = CityWeatherViewCellData(id: 0, title: data.city,
                                           subtitle: "",
                                           description: "",
                                           temperature: "",
                                           minmax: "",
                                           image: UIImage(systemName: "lock.fill"))
        let component = ListWeatherComponent.city(data: data)
        
        return component
    }
    
    private func getComponent(location: CLLocation,
                              weather: Weather,
                              local: Bool = false, address: Address) async throws -> ListWeatherComponent {
        
        locations.append(location)
        
        let imageData = try await dependencies.downloadIcon.execute(imageName: weather.information.first!.icon)
        let image = UIImage(data: imageData)
        
        let title = address.city.isEmpty ? address.town : address.city
        let data = CityWeatherViewCellData(id: weather.id, title: title,
                                           subtitle: local ? WeatherLanguage.myLocation : address.country,
                                           description: weather.information.first?.description ?? "",
                                           temperature: "\(weather.temperature.temp.toInt())º",
                                           minmax: "\(WeatherLanguage.maximum): \(weather.temperature.tempMax.toInt())º \(WeatherLanguage.minimum): \(weather.temperature.tempMin.toInt())º", 
                                           image: image)
        let component = ListWeatherComponent.city(data: data)
        
        return component
    }
    
    private func getAddress(coordinates: CLLocationCoordinate2D) async throws -> Address {
        try await dependencies.getAddress.execute(coordinates: coordinates)
    }
    
    func getWeather(index: Int) -> LocalWeather {
        if index == 0 || localWeathers.isEmpty, let currentLocation = self.currentLocation {
            let weather = LocalWeather(id: 0,
                                       latitude: currentLocation.coordinate.latitude,
                                       longitude: currentLocation.coordinate.longitude)
            return weather
        } else {
            let newIndex = currentLocation == nil ? index : index - 1
            let localWeather = localWeathers[newIndex]
            return localWeather
        }
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
        
        Task {
            try await deleteLocalWeather(id: id)
            let objects = try await dependencies.getLocalWeather.execute()
            localWeathers = objects
            components.send(newComponents)
        }
    }
    
    private func saveLocalWeather(coordinates: CLLocation,
                                  weather: Weather, 
                                  address: Address) async throws {
        
        let city = address.city.isEmpty ? address.town : address.city
        let object = LocalWeather(id: weather.id,
                                  latitude: coordinates.coordinate.latitude,
                                  longitude: coordinates.coordinate.longitude,
                                  registered: Date(), city: city)
        try await dependencies.saveLocalWeather.execute(object: object)
    }
    
    private func deleteLocalWeather(id: Int) async throws {
        
        let object = LocalWeather(id: id, latitude: 0, longitude: 0)
        try await dependencies.deleteLocalWeather.execute(object: object)
    }
    
    private func getLocalWeather() async throws -> [LocalWeather] {
        let objects = try await dependencies.getLocalWeather.execute()
        return objects
    }
    
    private func isPreviusSaved(id: Int) async throws -> Bool {
        let objects = try await getLocalWeather()
        return (objects.first(where: {$0.id == id}) != nil)
    }
    
    private func setLocalWeather() async throws {
        let objects = try await dependencies.getLocalWeather.execute()
        localWeathers = objects
        let components = try await objects.asyncMap({ element in
            let location = CLLocation(latitude: element.latitude, longitude: element.longitude)
            let address = try await getAddress(coordinates: location.coordinate)
            let weather = try await getWeather(location: location)
            return try await getComponent(location: location, weather: weather, address: address)
        })
        let newComponents = self.components.value + components
        self.components.send(newComponents)
    }
    
    private func getWeather(location: CLLocation) async throws -> Weather {
        let coordinates = WeatherCoordinates(latitude: location.coordinate.latitude,
                                             longitude: location.coordinate.longitude)
        let weather = try await dependencies.getWeather.execute(coordinates: coordinates)
        return weather
    }
    
    func featureUse(index: Int) -> ShowWeatherUse {
        guard let currentLocation = currentLocation?.coordinate.latitude else {
            return .read
        }
        return locations[index].coordinate.latitude == currentLocation ? .location : .read
    }
    
    func featureUse(location: CLLocation) -> ShowWeatherUse {
        let foundLocal = locations.first(where: {$0.coordinate.latitude == location.coordinate.latitude})
        if foundLocal != nil {
            return .read
        } else {
            return .add
        }
    }
    
    func updateDB() {
        Task {
            let objects = try await dependencies.getLocalWeather.execute()
            localWeathers = objects
        }
    }
    
    func isError() -> Bool {
        return self.haveError
    }
}
