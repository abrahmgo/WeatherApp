//
//  NetworkCoreConfig.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public protocol NetworkCoreAPIConfigType {
    static var baseURL: String { get }
    static var useSampleData: Bool { get }
    static var additionalHeaders: [String: String] { get }
    static var token: String { get }
    static var language: String { get }
}

public extension NetworkCoreAPIConfigType {
    
    static var additionalHeaders: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}

public final class NetworkCoreAPIConfig {
    
    public static var shared: NetworkCoreAPIConfig!
    
    public let baseURL: String
    public let useSampleData: Bool
    public let networkService: NetworkServiceType
    
    init(_ config: NetworkCoreAPIConfigType.Type) {
        
        self.baseURL = config.baseURL
        self.useSampleData = config.useSampleData
        
        if config.useSampleData {
            self.networkService = MockNetworkService()
        } else {
            self.networkService = NetworkService(baseURL: config.baseURL, 
                                                 headers: config.additionalHeaders,
                                                 token: config.token,
                                                 language: config.language)
        }
    }
}


