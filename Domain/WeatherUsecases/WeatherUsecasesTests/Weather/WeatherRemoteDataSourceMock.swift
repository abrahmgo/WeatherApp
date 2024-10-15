//
//  WeatherRemoteDataSourceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource
import WeatherEntities

struct WeatherRemoteDataSourceMock: WeatherRemoteDataSource {
    
    func get(model: WeatherEntities.WeatherRequest) async throws -> WeatherEntities.Weather {
        return Weather()
    }
}
