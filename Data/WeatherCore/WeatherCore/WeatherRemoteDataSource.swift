//
//  WeatherRemoteDataSource.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherDataSource
import NetoworkCore

public struct WeatherRemoteDataSource {
    
    public static var weather: WeatherDataSource.WeatherRemoteDataSource {
        return WeatherAPI(service: NetworkCoreAPIConfig.shared.networkService)
    }
}
