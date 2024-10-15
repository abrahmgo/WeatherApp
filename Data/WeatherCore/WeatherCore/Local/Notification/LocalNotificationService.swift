//
//  LocalNotificationService.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherEntities
import WeatherDataSource
import UserNotifications

struct LocalNotificationService: NotificationServiceLocalDataSource {
    
    func requestPermission() async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: granted)
                }
            }
        }
    }
    
    func remove(id: String) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        }
    }
    
    func schedule(model: WeatherEntities.LocalNotification) async throws {
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
