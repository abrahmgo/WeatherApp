//
//  WeatherDBLocalDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import WeatherEntities

public protocol WeatherDBLocalDataSource {
    func saveContext(object: LocalWeather) async throws 
    func getContext() async throws -> [LocalWeather]
    func deleteContext(id: Int) async throws
    func update(id: Int, notification: Bool) async throws 
}
