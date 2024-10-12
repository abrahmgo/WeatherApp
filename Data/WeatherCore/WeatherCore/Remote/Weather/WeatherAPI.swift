//
//  WeatherAPI.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherDataSource
import NetoworkCore
import WeatherEntities

struct WeatherAPI: WeatherDataSource.WeatherRemoteDataSource {
    
    private let service: NetworkServiceType
    
    init(service: NetworkServiceType) {
        self.service = service
    }
    
    func get(model: WeatherRequest) async throws -> Weather {
        let model = WeatherRequestModel(latitude: model.coordinates.latitude,
                                        longitude: model.coordinates.longitude,
                                        units: model.units)
        let endpoint = WeatherEndpoint(model: model)
        let request: WeatherResponseModel = try await service.request(target: endpoint)
        return request.mapToWeather()
    }
}
