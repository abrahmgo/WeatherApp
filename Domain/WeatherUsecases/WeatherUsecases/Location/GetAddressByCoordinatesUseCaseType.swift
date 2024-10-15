//
//  GetAddressByCoordinatesUseCaseType.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities
import CoreLocation
import WeatherDataSource

public protocol GetAddressByCoordinatesUseCaseType {
    func execute(coordinates: CLLocation) async throws -> Address
}

public struct GetAddressByCoordinatesUseCase: GetAddressByCoordinatesUseCaseType {
    
    private let geocoderService: GeocoderLocalDataSource
    
    public init(geocoderService: GeocoderLocalDataSource) {
        self.geocoderService = geocoderService
    }
    
    public func execute(coordinates: CLLocation) async throws -> Address {
        return try await geocoderService.execute(coordinates: coordinates)
    }
}
