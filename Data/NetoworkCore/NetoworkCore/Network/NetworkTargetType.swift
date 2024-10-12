//
//  NetworkTargetType.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public enum NetworkMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol NetworkTargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var sampleData: Data? { get }
    var body: Data? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    var retry: Bool { get }
}

public extension NetworkTargetType {
    
    var sampleData: Data? {
        return nil
    }
    
    var retry: Bool {
        return false
    }
}

extension NetworkTargetType {
    
    func url() -> String {
        return baseURL + path
    }
}
