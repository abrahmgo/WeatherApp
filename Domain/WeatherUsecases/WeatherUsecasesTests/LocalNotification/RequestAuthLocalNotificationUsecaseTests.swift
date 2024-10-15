//
//  RequestAuthLocalNotificationUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class RequestAuthLocalNotificationUsecaseTests: XCTestCase {

    var requestAuthLocalNotificationUsecase: RequestAuthLocalNotificationUsecaseType?
    
    override func setUpWithError() throws {
        let notificationSerive = LocalNotificationServiceMock()
        requestAuthLocalNotificationUsecase = RequestAuthLocalNotificationUsecase(localNotification: notificationSerive)
    }

    override func tearDownWithError() throws {
        requestAuthLocalNotificationUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let status = try await requestAuthLocalNotificationUsecase?.execute()
        XCTAssertNotNil(status)
    }
}
