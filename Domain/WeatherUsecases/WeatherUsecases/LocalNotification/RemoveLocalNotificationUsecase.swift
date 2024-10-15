//
//  RemoveLocalNotificationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource

public protocol RemoveLocalNotificationUsecaseType {
    func execute(id: String) async throws
}

public struct RemoveLocalNotificationUsecase: RemoveLocalNotificationUsecaseType {
    
    private let localNotification: NotificationServiceLocalDataSource
    
    public init(localNotification: NotificationServiceLocalDataSource) {
        self.localNotification = localNotification
    }
    
    public func execute(id: String) async throws {
        try await localNotification.remove(id: id)
    }
}
