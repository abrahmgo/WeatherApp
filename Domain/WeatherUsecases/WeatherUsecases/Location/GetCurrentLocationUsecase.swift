//
//  GetCurrentLocationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Combine
import CoreLocation
import WeatherCore
import WeatherDataSource

public protocol GetCurrentLocationUseCaseType {
    func execute() -> AnyPublisher<CLLocation, Error>
}

public struct GetCurrentLocationUseCase: GetCurrentLocationUseCaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute() -> AnyPublisher<CLLocation, Error> {
        return locationService.currentLocation.eraseToAnyPublisher()
    }
}
