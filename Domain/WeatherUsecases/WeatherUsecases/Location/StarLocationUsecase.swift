//
//  StarLocationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities
import WeatherDataSource
import WeatherCore

public protocol StarLocalizationUseCaseType {
    func execute(type: RequestLocationType) async throws
}

public struct StarLocalizationUseCase: StarLocalizationUseCaseType {
    
    private let locationService: LocationServiceType
    
    public init(locationService: LocationServiceType) {
        self.locationService = locationService
    }
    
    public func execute(type: RequestLocationType) async throws {
        let status = try await locationService.authorizationStatus()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            return try await locationService.requestLocation()
        } else if status == .notDetermined {
            return try await locationService.askLocationPermits(type: type)
        } else {
            throw WeatherError.LocationRequestService
        }
    }
}
