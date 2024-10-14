//
//  GetLocalNotifcationAuthUsecase.swift
//  WeatherUsecases
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation
import UserNotifications

public protocol GetLocalNotifcationAuthUsecaseType {
    func execute() async throws -> Bool
}

public struct GetLocalNotifcationAuthUsecase: GetLocalNotifcationAuthUsecaseType {
    
    public init() { }
    
    public func execute() async throws -> Bool {
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
}
