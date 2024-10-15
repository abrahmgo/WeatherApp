//
//  WeatherIconAPITests.swift
//  WeatherCoreTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest

@testable import WeatherCore
@testable import WeatherEntities
@testable import NetoworkCore
@testable import WeatherDataSource

final class WeatherIconAPITests: XCTestCase {

    var weatherIconAPI: WeatherDataSource.WeatherIconRemoteDataSource?
    
    override func setUpWithError() throws {
        NetworkCoreAPI.setup(with: APIConfigMock.self)
        weatherIconAPI = WeatherRemoteDataSource.icon
    }

    override func tearDownWithError() throws {
        weatherIconAPI = nil
    }
    
    func testGetWeatherAPI() async throws {
        let icon = try await weatherIconAPI?.execute(imageName: "")
        XCTAssertNotNil(icon)
    }
}

