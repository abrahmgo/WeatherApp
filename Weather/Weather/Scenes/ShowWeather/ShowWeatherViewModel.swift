//
//  CurrentLocationViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUI
import WeatherEntities
import CoreLocation

class ShowWeatherViewModel: ShowWeatherViewModelType, ShowWeatherViewModelInputs, ShowWeatherViewModelOutputs {

    // MARK: Properties
    var outputs: ShowWeatherViewModelOutputs { return self }
    var inputs: ShowWeatherViewModelInputs { return self }
    
    // MARK: Outputs
    var components: CurrentValueSubject<[ShowWeatherComponents], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    
    // MARK: Private
    private let dependencies: ShowWeatherDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public init(dependencies: ShowWeatherDependencies) {
        self.dependencies = dependencies
        
        setComponents()
    }
    
    private func setComponents() {
        binds()
    }

    private func binds() {
        Task {
            do {
                let address = try await self.dependencies.getAddressByCoordinates.execute(coordinates: dependencies.coordinates.coordinate)
                
                let weatherCoordinates = WeatherCoordinates(latitude: dependencies.coordinates.coordinate.latitude.magnitude,
                                                            longitude: dependencies.coordinates.coordinate.longitude.magnitude)
                let weather = try await self.dependencies.getWeather.execute(coordinates: weatherCoordinates)
                
                let titleData = TitleTableViewCellData(title: dependencies.isCurrentLocation ? "Mi Ubicacion" : "",
                                                       subtitle: address.city + " " + address.state)
                let titleComponent = ShowWeatherComponents.headerTitle(data: titleData)
                
                let spaceData = SpaceViewCellData(height: 15)
                let spaceComponent = ShowWeatherComponents.space(data: spaceData)
                
                let temperatureData = TitleNumberViewCellData(number: "\(weather.temperature.temp.toInt())º",
                                                              title: weather.information.first!.description,
                                                              subtitle: "min: \(weather.temperature.tempMin.toInt())º max \(weather.temperature.tempMax.toInt())º")
                let weatherComponent = ShowWeatherComponents.temperature(data: temperatureData)
                
                let informationData = InformationViewCellData(humidty: weather.temperature.humidity.toInt(),
                                                              pressure: weather.temperature.pressure.toInt(),
                                                              pressureSea: weather.temperature.seaLevel.toInt(),
                                                              pressureGround: weather.temperature.grndLevel.toInt())
                let informationComponent = ShowWeatherComponents.information(data: informationData)
                
                self.components.send([spaceComponent, titleComponent,
                                      spaceComponent, weatherComponent,
                                      spaceComponent, informationComponent])
            } catch {
                
            }
        }
    }
    
    func getCoordinates() -> CLLocation {
        dependencies.coordinates
    }
    
    func isCurrentLocation() -> Bool {
        dependencies.isCurrentLocation
    }
}
