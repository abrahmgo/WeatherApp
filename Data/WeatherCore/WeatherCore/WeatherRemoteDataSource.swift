//
//  WeatherRemoteDataSource.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherDataSource
import NetoworkCore

public struct WeatherRemoteDataSource {
    
    static var bundle: Bundle? {
        return Bundle(identifier: "com.andres.WeatherCore")
    }
    
    public static var weather: WeatherDataSource.WeatherRemoteDataSource {
        return WeatherAPI(service: NetworkCoreAPIConfig.shared.networkService)
    }
    
    public static var icon: WeatherDataSource.WeatherIconRemoteDataSource {
        return WeatherIconAPI(service: NetworkCoreAPIConfig.shared.networkService)
    }
}
