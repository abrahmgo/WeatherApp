//
//  GetCurrentLocationStatusUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource
import Combine
import CoreLocation

public protocol GetCurrentLocationStatusUsecaseType {
    func execute() -> AnyPublisher<CLAuthorizationStatus, Never>
}

public struct GetCurrentLocationStatusUsecase: GetCurrentLocationStatusUsecaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute() -> AnyPublisher<CLAuthorizationStatus, Never> {
        return locationService.currentAuthStatus.eraseToAnyPublisher()
    }
}
