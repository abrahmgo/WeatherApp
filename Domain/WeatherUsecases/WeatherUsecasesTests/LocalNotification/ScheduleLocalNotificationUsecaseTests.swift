//
//  ScheduleLocalNotificationUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class ScheduleLocalNotificationUsecaseTests: XCTestCase {

    var scheduleLocalNotificationUsecase: ScheduleLocalNotificationUsecaseType?
    
    override func setUpWithError() throws {
        let notificationSerive = LocalNotificationServiceMock()
        scheduleLocalNotificationUsecase = ScheduleLocalNotificationUsecase(localNotification: notificationSerive)
    }

    override func tearDownWithError() throws {
        scheduleLocalNotificationUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let model = LocalNotification(id: "2", title: "", body: "")
        try await scheduleLocalNotificationUsecase?.execute(model: model)
    }
}
