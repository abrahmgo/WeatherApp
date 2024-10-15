//
//  WeatherIconRemoteDataSourceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource
import WeatherEntities

struct WeatherIconRemoteDataSourceMock: WeatherIconRemoteDataSource {
    
    func execute(imageName: String) async throws -> Data {
        return Data(repeating: 23, count: 1)
    }
}

