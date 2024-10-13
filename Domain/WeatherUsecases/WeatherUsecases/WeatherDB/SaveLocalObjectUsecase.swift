//
//  SaveLocalObjectUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import WeatherDataSource
import WeatherEntities

public protocol SaveLocalObjectUsecaseType {
    func execute(object: LocalWeather) async throws
}

public struct SaveLocalObjectUsecase: SaveLocalObjectUsecaseType {
    
    private let localDB: WeatherDBLocalDataSource
    
    public init(localDB: WeatherDBLocalDataSource) {
        self.localDB = localDB
    }
    
    public func execute(object: LocalWeather) async throws {
        try await localDB.saveContext(object: object)
    }
}
