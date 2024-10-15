//
//  GeocoderServiceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherDataSource
import WeatherEntities
import CoreLocation

struct GeocoderServiceMock: GeocoderLocalDataSource {
    
    func execute(coordinates: CLLocation) async throws -> WeatherEntities.Address {
        return Address()
    }
}
