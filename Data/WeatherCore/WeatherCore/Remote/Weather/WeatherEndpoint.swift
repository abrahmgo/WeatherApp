//
//  WeatherEndpoint.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import NetoworkCore

struct WeatherEndpoint: NetworkTargetType {
    
    private let model: WeatherRequestModel
    
    init(model: WeatherRequestModel) {
        self.model = model
    }
    
    var baseURL: String {
        return ""
    }
    
    var path: String {
        return "data/2.5/weather"
    }
    
    var method: NetoworkCore.NetworkMethod {
        return .GET
    }
    
    var body: Data?
    
    var queryParams: [String : Any]? {
        return ["lat": model.latitude,
                "lon": model.longitude,
                "units": model.units.rawValue]
    }
    
    var headers: [String : String]?
    
    var sampleData: Data? {
        let bundle = WeatherRemoteDataSource.bundle
        let sampleData = NetworkCoreSampleData(bundle: bundle)
        
        return sampleData.getData(for: "WeatherAPIExample")
    }
}
