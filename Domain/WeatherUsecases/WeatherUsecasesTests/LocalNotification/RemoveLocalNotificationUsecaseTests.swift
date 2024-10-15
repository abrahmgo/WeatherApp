//
//  RemoveLocalNotificationUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class RemoveLocalNotificationUsecaseTests: XCTestCase {

    var removeLocalNotificationUsecase: RemoveLocalNotificationUsecaseType?
    
    override func setUpWithError() throws {
        let notificationSerive = LocalNotificationServiceMock()
        removeLocalNotificationUsecase = RemoveLocalNotificationUsecase(localNotification: notificationSerive)
    }

    override func tearDownWithError() throws {
        removeLocalNotificationUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        try await removeLocalNotificationUsecase?.execute(id: "2")
    }
}
