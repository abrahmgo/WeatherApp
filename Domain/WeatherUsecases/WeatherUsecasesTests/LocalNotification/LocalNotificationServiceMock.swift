//
//  LocalNotificationServiceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherEntities
import WeatherDataSource

struct LocalNotificationServiceMock: NotificationServiceLocalDataSource {
    
    func requestPermission() async throws -> Bool {
        true
    }
    
    func remove(id: String) async throws { }
    
    func schedule(model: WeatherEntities.LocalNotification) async throws { }
}
