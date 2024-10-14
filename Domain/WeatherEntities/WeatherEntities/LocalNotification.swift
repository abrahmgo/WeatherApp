//
//  LocalNotification.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

public struct LocalNotification {
    public let id: String
    public let title: String
    public let body: String
    public let time: LocalNotificationTime
    public let `repeat`: Bool
    
    public init(id: String,
                title: String,
                body: String, 
                time: LocalNotificationTime = .fast,
                repeat: Bool = true) {
        self.id = id
        self.title = title
        self.body = body
        self.time = time
        self.repeat = `repeat`
    }
}

public enum LocalNotificationTime: Double {
    // 1 minute
    case fast = 60
    // 5 minutes
    case medium = 300
    // 10 minutes
    case long = 600
}
