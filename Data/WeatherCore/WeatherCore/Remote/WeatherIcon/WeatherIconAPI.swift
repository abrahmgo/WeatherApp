//
//  WeatherIconAPI.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import WeatherDataSource
import NetoworkCore

struct WeatherIconAPI: WeatherIconRemoteDataSource {
    
    private let service: NetworkServiceType
    
    init(service: NetworkServiceType) {
        self.service = service
    }
    
    func execute(imageName: String) async throws -> Data {
        let model = WeatherIconRequestModel(imageName: imageName)
        let endpoint = WeatherIconEndpoint(model: model)
        let request: Data = try await service.request(target: endpoint)
        return request
    }
}
