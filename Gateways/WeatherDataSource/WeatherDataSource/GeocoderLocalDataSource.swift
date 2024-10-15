//
//  GeocoderLocalDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import CoreLocation
import WeatherEntities

public protocol GeocoderLocalDataSource {
    func execute(coordinates: CLLocation) async throws -> Address
}
