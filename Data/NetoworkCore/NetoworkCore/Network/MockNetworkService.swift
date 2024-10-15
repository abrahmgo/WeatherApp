//
//  MockNetworkService.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

struct MockNetworkService: NetworkServiceType {
    
    init() { }
    
    func request<T>(target: NetworkTargetType) async throws -> T where T : Decodable {
        
        let endpoint = target.url()
        
        print("Mock: \(endpoint) 🎁")
        
        guard let sampleData = target.sampleData else {
            throw NetworkError.withoutSampleData
        }
        
        if let decoded = try? JSONDecoder().decode(T.self, from: sampleData) {
            return decoded
        } else {
            throw NetworkError.checkFormatSampleData
        }
    }
    
    func request(target: NetworkTargetType) async throws -> Data {
        print("Mock: \(target.url()) 🎁")
        return target.sampleData ?? Data()
    }
}
