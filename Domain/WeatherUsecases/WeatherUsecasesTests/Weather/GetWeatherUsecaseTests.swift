//
//  GetWeatherUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class GetWeatherUsecaseTests: XCTestCase {

    var getWeatherUsecase: GetWeatherUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherRemoteDataSourceMock()
        getWeatherUsecase = GetWeatherUsecase(remoteDataSource: mock)
    }

    override func tearDownWithError() throws {
        getWeatherUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let coordinates = WeatherCoordinates(latitude: 0, longitude: 0)
        let weather = try await getWeatherUsecase?.execute(coordinates: coordinates)
        XCTAssertNotNil(weather)
    }
}
