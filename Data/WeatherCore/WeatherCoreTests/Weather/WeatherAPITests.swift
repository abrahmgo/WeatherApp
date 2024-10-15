//
//  WeatherAPITests.swift
//  WeatherCoreTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest

@testable import WeatherCore
@testable import WeatherEntities
@testable import NetoworkCore
@testable import WeatherDataSource

final class WeatherAPITests: XCTestCase {

    var weatherAPI: WeatherDataSource.WeatherRemoteDataSource?
    
    override func setUpWithError() throws {
        NetworkCoreAPI.setup(with: APIConfigMock.self)
        weatherAPI = WeatherRemoteDataSource.weather
    }

    override func tearDownWithError() throws {
        weatherAPI = nil
    }
    
    func testGetWeatherAPI() async throws {
        let coordinates = WeatherCoordinates(latitude: 0, longitude: 0)
        let model = WeatherRequest(coordinates: coordinates)
        let address = try await weatherAPI?.get(model: model)
        XCTAssertNotNil(address)
    }
}
