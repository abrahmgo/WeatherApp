//
//  RequestAuthLocalNotificationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherDataSource
import UserNotifications

public protocol RequestAuthLocalNotificationUsecaseType {
    func execute() async throws -> Bool
}

public struct RequestAuthLocalNotificationUsecase: RequestAuthLocalNotificationUsecaseType {
    
    private let localNotification: NotificationServiceLocalDataSource
    
    public init(localNotification: NotificationServiceLocalDataSource) {
        self.localNotification = localNotification
    }
    
    public func execute() async throws -> Bool {
        try await localNotification.requestPermission()
    }
}
