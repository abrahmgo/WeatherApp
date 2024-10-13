//
//  WeatherIconRemoteDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Foundation

public protocol WeatherIconRemoteDataSource {
    func execute(imageName: String) async throws -> Data
}
