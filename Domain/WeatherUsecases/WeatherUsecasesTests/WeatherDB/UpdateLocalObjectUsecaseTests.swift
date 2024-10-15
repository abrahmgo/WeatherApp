//
//  UpdateLocalObjectUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class UpdateLocalObjectUsecaseTests: XCTestCase {

    var updateLocalObjectUsecase: UpdateLocalObjectUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherDBLocalDataSourceMock()
        updateLocalObjectUsecase = UpdateLocalObjectUsecase(localDB: mock)
    }

    override func tearDownWithError() throws {
        updateLocalObjectUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        try await updateLocalObjectUsecase?.execute(id: 0, notification: false)
    }
}
