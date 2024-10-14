//
//  UpdateLocalObjectUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource

public protocol UpdateLocalObjectUsecaseType {
    func execute(id: Int, notification: Bool) async throws
}

public struct UpdateLocalObjectUsecase: UpdateLocalObjectUsecaseType {
    
    private let localDB: WeatherDBLocalDataSource
    
    public init(localDB: WeatherDBLocalDataSource) {
        self.localDB = localDB
    }
    
    public func execute(id: Int, notification: Bool) async throws {
        try await localDB.update(id: id, notification: notification)
    }
}
