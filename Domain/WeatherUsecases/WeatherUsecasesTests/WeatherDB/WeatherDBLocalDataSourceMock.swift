//
//  WeatherDBLocalDataSourceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherEntities
import WeatherDataSource

struct WeatherDBLocalDataSourceMock: WeatherDBLocalDataSource {
    
    func saveContext(object: WeatherEntities.LocalWeather) async throws { }
    
    func getContext() async throws -> [WeatherEntities.LocalWeather] {
        return [LocalWeather(id: 0, latitude: 0, longitude: 0)]
    }
    
    func deleteContext(id: Int) async throws { }
    
    func update(id: Int, notification: Bool) async throws { }
}
