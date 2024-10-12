//
//  GetAddressByCoordinatesUseCaseType.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities
import CoreLocation

public protocol GetAddressByCoordinatesUseCaseType {
    func execute(coordinates: CLLocationCoordinate2D) async throws -> Address
}

public struct GetAddressByCoordinatesUseCase: GetAddressByCoordinatesUseCaseType {
    
    private let geoCoder = CLGeocoder()
    
    public init() { }
    
    public func execute(coordinates: CLLocationCoordinate2D) async throws -> Address {
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        return try await withCheckedThrowingContinuation { continuation in
            geoCoder.reverseGeocodeLocation(location) { placemark, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let address = placemark?.first {
                    let address = Address(place: address)
                    continuation.resume(returning: address)
                } else {
                    continuation.resume(throwing: LocationError.notAddressFound)
                }
            }
        }
    }
}
