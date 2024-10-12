//
//  NetworkError.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public enum NetworkError: Error {
    case notDacodedData
    case checkRequest
    case withoutSampleData
    case checkFormatSampleData
    case invalidURL
}
