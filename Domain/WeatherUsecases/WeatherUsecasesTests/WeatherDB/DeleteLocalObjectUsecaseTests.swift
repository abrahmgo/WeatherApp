//
//  DeleteLocalObjectUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest

@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class DeleteLocalObjectUsecaseTests: XCTestCase {

    var deleteLocalObjectUsecase: DeleteLocalObjectUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherDBLocalDataSourceMock()
        deleteLocalObjectUsecase = DeleteLocalObjectUsecase(localDB: mock)
    }

    override func tearDownWithError() throws {
        deleteLocalObjectUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let object = LocalWeather(id: 0, latitude: 0, longitude: 0)
        try await deleteLocalObjectUsecase?.execute(object: object)
    }
}
