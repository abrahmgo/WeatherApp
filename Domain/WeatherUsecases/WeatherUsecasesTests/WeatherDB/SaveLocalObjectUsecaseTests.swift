//
//  SaveLocalObjectUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class SaveLocalObjectUsecaseTests: XCTestCase {

    var saveLocalObjectUsecase: SaveLocalObjectUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherDBLocalDataSourceMock()
        saveLocalObjectUsecase = SaveLocalObjectUsecase(localDB: mock)
    }

    override func tearDownWithError() throws {
        saveLocalObjectUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let object = LocalWeather(id: 0, latitude: 0, longitude: 0)
        try await saveLocalObjectUsecase?.execute(object: object)
    }
}
