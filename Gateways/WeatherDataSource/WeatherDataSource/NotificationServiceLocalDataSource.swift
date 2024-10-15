//
//  NotificationServiceLocalDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherEntities

public protocol NotificationServiceLocalDataSource {
    func requestPermission() async throws -> Bool
    func remove(id: String) async throws
    func schedule(model: LocalNotification) async throws
}
