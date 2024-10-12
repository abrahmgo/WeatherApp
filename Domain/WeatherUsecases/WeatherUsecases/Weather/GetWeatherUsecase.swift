//
//  GetWeatherUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherEntities
import WeatherCore
import WeatherDataSource

public protocol GetWeatherUsecaseType {
    func execute(coordinates: WeatherCoordinates) async throws -> Weather
}

public struct GetWeatherUsecase: GetWeatherUsecaseType {
    
    private let remoteDataSource: WeatherDataSource.WeatherRemoteDataSource
    
    public init(remoteDataSource: WeatherDataSource.WeatherRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func execute(coordinates: WeatherCoordinates) async throws -> Weather {
        let model = WeatherRequest(coordinates: coordinates)
        return try await remoteDataSource.get(model: model)
    }
}
