//
//  StarLocalizationUseCaseTests.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
@testable import WeatherEntities
@testable import WeatherUsecases
@testable import WeatherDataSource

final class StarLocalizationUseCaseTests: XCTestCase {

    var starLocalizationUseCase: StarLocalizationUseCaseType?
    
    override func setUpWithError() throws {
        let locationService = LocationServiceMock()
        starLocalizationUseCase = StarLocalizationUseCase(locationService: locationService)
    }

    override func tearDownWithError() throws {
        starLocalizationUseCase = nil
    }

    func testGetWeatherUsecase() async throws {
        try await starLocalizationUseCase?.execute(type: .always)
    }
}
