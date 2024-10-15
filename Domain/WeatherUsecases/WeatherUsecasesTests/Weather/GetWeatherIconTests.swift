//
//  GetWeatherIconTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class GetWeatherIconTests: XCTestCase {

    var getWeatherIconUsecase: GetWeatherIconUsecaseType?
    
    override func setUpWithError() throws {
        let mock = WeatherIconRemoteDataSourceMock()
        getWeatherIconUsecase = GetWeatherIconUsecase(remoteDataSource: mock)
    }

    override func tearDownWithError() throws {
        getWeatherIconUsecase = nil
    }

    func testGetIcon() async throws {
        let icon = try await getWeatherIconUsecase?.execute(imageName: "")
        XCTAssertNotNil(icon)
    }
}
