//
//  GeocoderService.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherDataSource
import WeatherEntities
import CoreLocation

struct GeocoderService: GeocoderLocalDataSource {
    
    private let geoCoder = CLGeocoder()
    
    func execute(coordinates: CLLocation) async throws -> WeatherEntities.Address {
        return try await withCheckedThrowingContinuation { continuation in
            geoCoder.reverseGeocodeLocation(coordinates) { placemark, error in
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
