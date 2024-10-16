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
import UIKit
import Localizable
import Utils

class ShowWeatherViewModel: ShowWeatherViewModelType, ShowWeatherViewModelInputs, ShowWeatherViewModelOutputs {
    
    // MARK: Properties
    var outputs: ShowWeatherViewModelOutputs { return self }
    var inputs: ShowWeatherViewModelInputs { return self }
    
    // MARK: Outputs
    var components: CurrentValueSubject<[ShowWeatherComponents], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    var isNotificationActive: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    
    
    // MARK: Private
    private let dependencies: ShowWeatherDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var id: Int = 0
    private var address: Address?
    
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
                
                let location = CLLocation(latitude: dependencies.localWeather.latitude,
                                          longitude: dependencies.localWeather.longitude)
                let address = try await self.dependencies.getAddressByCoordinates.execute(coordinates: location)
                self.address = address
                let weatherCoordinates = WeatherCoordinates(latitude: location.coordinate.latitude,
                                                            longitude: location.coordinate.longitude)
                let weather = try await self.dependencies.getWeather.execute(coordinates: weatherCoordinates)
                
                let title = getTitle()
                let subtitle = address.city.isEmpty ? address.town : address.city
                let titleData = TitleTableViewCellData(title: title,
                                                       subtitle: subtitle + " " + address.state)
                let titleComponent = ShowWeatherComponents.headerTitle(data: titleData)
                
                let spaceData = SpaceViewCellData(height: 15)
                let spaceComponent = ShowWeatherComponents.space(data: spaceData)
                
                let temperatureData = TitleNumberViewCellData(number: "\(weather.temperature.temp.toInt())º",
                                                              title: weather.information.first!.description,
                                                              subtitle: "\(WeatherLanguage.minimum): \(weather.temperature.tempMin.toInt())º \(WeatherLanguage.maximum) \(weather.temperature.tempMax.toInt())º")
                let weatherComponent = ShowWeatherComponents.temperature(data: temperatureData)
                
                let informationData = InformationViewCellData(humidty: weather.temperature.humidity.toInt(),
                                                              pressure: weather.temperature.pressure.toInt(),
                                                              pressureSea: weather.temperature.seaLevel.toInt(),
                                                              pressureGround: weather.temperature.grndLevel.toInt())
                let informationComponent = ShowWeatherComponents.information(data: informationData)
                
                let footerText = "\(WeatherLanguage.registered) \(dependencies.localWeather.registered.toSring(format: .completeYearMonthDaySlash))"
                let footerData = FooterViewCellData(text: footerText)
                let footerComponent = ShowWeatherComponents.footer(data: footerData)
                
                
                let icon = try await self.dependencies.downloadIcon.execute(imageName: weather.information.first!.icon)
                let image = UIImage(data: icon)
                let iconData = IconViewCellData(image: image)
                let iconComponent = ShowWeatherComponents.icon(data: iconData)
                self.components.send([iconComponent, spaceComponent, titleComponent,
                                      spaceComponent, weatherComponent,
                                      spaceComponent, informationComponent, footerComponent])
            } catch {
                
            }
        }
    }
    
    private func getTitle() -> String {
        switch dependencies.featureUse {
        case .add:
            return ""
        case .location:
            return WeatherLanguage.myLocation
        case .read:
            isNotificationActive.send(dependencies.localWeather.notification)
            return ""
        }
    }
    
    func getCoordinates() -> CLLocation {
        let location = CLLocation(latitude: dependencies.localWeather.latitude,
                                  longitude: dependencies.localWeather.longitude)
        return location
    }
    
    func featureUse() -> ShowWeatherUse {
        dependencies.featureUse
    }
    
    func pressNotification() {
        let currentValue = isNotificationActive.value
        Task {
            isNotificationActive.send(!currentValue)
            let id = self.dependencies.localWeather.id
            try await dependencies.updateObject.execute(id: self.dependencies.localWeather.id,
                                                        notification: self.isNotificationActive.value)
            let newCurrentValue = isNotificationActive.value
            if newCurrentValue {
                let city = self.address?.city ?? ""
                let notificationModel = LocalNotification(id: "\(id)",
                                                          title: WeatherLanguage.notificationTitle,
                                                          body: "\(WeatherLanguage.notificationBody) " + city ,
                                                          time: .fast)
                try await dependencies.setNotification.execute(model: notificationModel)
            } else {
                try await dependencies.removeNotification.execute(id: "\(id)")
            }
        }
    }
}
