//
//  WeatherIconEndpoint.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import NetoworkCore

struct WeatherIconEndpoint: NetworkTargetType {
    
    private let model: WeatherIconRequestModel
    
    init(model: WeatherIconRequestModel) {
        self.model = model
    }
    
    var baseURL: String {
        return "https://openweathermap.org"
    }
    
    var path: String {
        return "/img/wn/" + model.imageName + "@2x.png"
    }
    
    var method: NetoworkCore.NetworkMethod {
        return .GET
    }
    
    var body: Data? {
        return nil
    }
    
    var queryParams: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
}
