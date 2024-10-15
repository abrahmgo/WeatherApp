//
//  GetAddressByCoordinatesUsecaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
import CoreLocation
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class GetAddressByCoordinatesUsecaseTests: XCTestCase {

    var getAddressByCoordinatesUsecase: GetAddressByCoordinatesUseCaseType?
    
    override func setUpWithError() throws {
        let geocoderService = GeocoderServiceMock()
        getAddressByCoordinatesUsecase = GetAddressByCoordinatesUseCase(geocoderService: geocoderService)
    }

    override func tearDownWithError() throws {
        getAddressByCoordinatesUsecase = nil
    }

    func testGetWeatherUsecase() async throws {
        let location = CLLocation(latitude: 10, longitude: 10)
        let address = try await getAddressByCoordinatesUsecase?.execute(coordinates: location)
        XCTAssertNotNil(address)
    }
}
