//
//  WeatherRemoteDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities

public protocol WeatherRemoteDataSource {
    func get(model: WeatherRequest) async throws -> Weather
}
