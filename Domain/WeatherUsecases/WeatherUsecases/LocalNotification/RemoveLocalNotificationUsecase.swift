//
//  RemoveLocalNotificationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UserNotifications

public protocol RemoveLocalNotificationUsecaseType {
    func execute(id: String) async throws
}

public struct RemoveLocalNotificationUsecase: RemoveLocalNotificationUsecaseType {
    
    public init() { }
    
    public func execute(id: String) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        }
    }
}
