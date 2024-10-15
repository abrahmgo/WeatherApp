//
//  GetLocalObjectUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class GetLocalObjectUsecaseTests: XCTestCase {

    var getLocalObjectUsecaseType: GetLocalObjectUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherDBLocalDataSourceMock()
        getLocalObjectUsecaseType = GetLocalObjectUsecase(localDB: mock)
    }

    override func tearDownWithError() throws {
        getLocalObjectUsecaseType = nil
    }

    func testGetWeatherUsecase() async throws {
        let objects = try await getLocalObjectUsecaseType?.execute()
        XCTAssertNotNil(objects)
    }
}
