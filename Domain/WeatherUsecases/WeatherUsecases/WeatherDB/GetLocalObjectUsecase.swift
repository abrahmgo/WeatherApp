//
//  GetLocalObjectUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import WeatherDataSource
import WeatherEntities

public protocol GetLocalObjectUsecaseType {
    func execute() async throws -> [LocalWeather]
}

public struct GetLocalObjectUsecase: GetLocalObjectUsecaseType {
    
    private let localDB: WeatherDBLocalDataSource
    
    public init(localDB: WeatherDBLocalDataSource) {
        self.localDB = localDB
    }
    
    public func execute() async throws -> [LocalWeather] {
        let data = try await localDB.getContext()
        return data
    }
}
