//
//  ScheduleLocalNotificationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherEntities
import UserNotifications
import WeatherDataSource

public protocol ScheduleLocalNotificationUsecaseType {
    func execute(model: LocalNotification) async throws
}

public struct ScheduleLocalNotificationUsecase: ScheduleLocalNotificationUsecaseType {
    
    private let localNotification: NotificationServiceLocalDataSource
    
    public init(localNotification: NotificationServiceLocalDataSource) {
        self.localNotification = localNotification
    }
    
    public func execute(model: LocalNotification) async throws {
        try await localNotification.schedule(model: model)
    }
}
