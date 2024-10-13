//
//  DeleteLocalObjectUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import WeatherEntities
import WeatherDataSource

public protocol DeleteLocalObjectUsecaseType {
    func execute(object: LocalWeather) async throws
}

public struct DeleteLocalObjectUsecase: DeleteLocalObjectUsecaseType {
    
    private let localDB: WeatherDBLocalDataSource
    
    public init(localDB: WeatherDBLocalDataSource) {
        self.localDB = localDB
    }
    
    public func execute(object: LocalWeather) async throws {
        try await localDB.deleteContext(id: object.id)
    }
}
