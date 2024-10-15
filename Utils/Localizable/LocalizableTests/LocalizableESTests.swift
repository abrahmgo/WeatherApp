//
//  LocalizableESTests.swift
//  LocalizableTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import XCTest
import Utils
@testable import Localizable

final class LocalizableESTests: XCTestCase {

    var localizableService: LocalizableService?
    
    override func setUpWithError() throws {
        localizableService = LocalizableService(language: .es)
    }

    override func tearDownWithError() throws {
        localizableService = nil
    }

    func testENString() throws {
        guard let title = localizableService?.get(key: "myLocation") else {
            throw ""
        }
        XCTAssertTrue(title == "Mi ubicación")
    }
}
