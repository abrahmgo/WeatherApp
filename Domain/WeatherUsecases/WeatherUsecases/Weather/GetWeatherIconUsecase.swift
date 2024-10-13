//
//  GetWeatherIconUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherDataSource

public protocol GetWeatherIconUsecaseType {
    func execute(imageName: String) async throws -> Data
}

public struct GetWeatherIconUsecase: GetWeatherIconUsecaseType {
    
    private let remoteDataSource: WeatherDataSource.WeatherIconRemoteDataSource
    
    public init(remoteDataSource: WeatherDataSource.WeatherIconRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func execute(imageName: String) async throws -> Data {
        try await remoteDataSource.execute(imageName: imageName)
    }
}
