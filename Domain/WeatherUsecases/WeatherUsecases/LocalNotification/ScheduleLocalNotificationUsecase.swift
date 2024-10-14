//
//  ScheduleLocalNotificationUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherEntities
import UserNotifications

public protocol ScheduleLocalNotificationUsecaseType {
    func execute(model: LocalNotification) async throws
}

public struct ScheduleLocalNotificationUsecase: ScheduleLocalNotificationUsecaseType {
    
    public init() { }
    
    public func execute(model: LocalNotification) async throws {
        let content = UNMutableNotificationContent()
        content.title = model.title
        content.body = model.body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: model.time.rawValue, repeats: model.repeat)
        let request = UNNotificationRequest(identifier: model.id, content: content, trigger: trigger)
        
        
        return try await withCheckedThrowingContinuation { continuation in
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}
