//
//  CurrentLocationViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUI
import WeatherEntities

class CurrentLocationViewModel: CurrentLocationViewModelType, CurrentLocationViewModelInputs, CurrentLocationViewModelOutputs {

    // MARK: Properties
    var outputs: CurrentLocationViewModelOutputs { return self }
    var inputs: CurrentLocationViewModelInputs { return self }
    
    // MARK: Outputs
    var components: CurrentValueSubject<[CurrentLocationComponents], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    
    // MARK: Private
    private let dependencies: CurrentLocationDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public init(dependencies: CurrentLocationDependencies) {
        self.dependencies = dependencies
        
        setComponents()
    }
    
    private func setComponents() {
        binds()
        getLocation()
    }
    
    private func getLocation() {
        Task {
            do {
                try await dependencies.startLocation.execute(type: .always)
            } catch {
                
            }
        }
    }
    
    private func binds() {
        dependencies.getCurrentLocation.execute()
            .sink(receiveCompletion: { _ in}) { location in
                Task {
                    do {
                        let address = try await self.dependencies.getAddressByCoordinates.execute(coordinates: location.coordinate)
                        
                        let weatherCoordinates = WeatherCoordinates(latitude: location.coordinate.latitude.magnitude,
                                                                    longitude: location.coordinate.longitude.magnitude)
                        let weather = try await self.dependencies.getWeather.execute(coordinates: weatherCoordinates)
                        
                        let titleData = TitleTableViewCellData(title: "Mi Ubicacion",
                                                               subtitle: address.city + " " + address.state)
                        let titleComponent = CurrentLocationComponents.headerTitle(data: titleData)
                        
                        let spaceData = SpaceViewCellData(height: 15)
                        let spaceComponent = CurrentLocationComponents.space(data: spaceData)
                        
                        let temperatureData = TitleNumberViewCellData(number: "\(weather.temperature.temp.toInt())º",
                                                                      title: weather.information.first!.description,
                                                                      subtitle: "min: \(weather.temperature.tempMin.toInt())º max \(weather.temperature.tempMax.toInt())º")
                        let weatherComponent = CurrentLocationComponents.temperature(data: temperatureData)
                        
                        let informationData = InformationViewCellData(humidty: weather.temperature.humidity.toInt(),
                                                                      pressure: weather.temperature.pressure.toInt(),
                                                                      pressureSea: weather.temperature.seaLevel.toInt(),
                                                                      pressureGround: weather.temperature.grndLevel.toInt())
                        let informationComponent = CurrentLocationComponents.information(data: informationData)
                        
                        self.components.send([spaceComponent, titleComponent,
                                              spaceComponent, weatherComponent,
                                              spaceComponent, informationComponent])
                    } catch {
                        
                    }
                }
            }.store(in: &cancellable)
    }
}
