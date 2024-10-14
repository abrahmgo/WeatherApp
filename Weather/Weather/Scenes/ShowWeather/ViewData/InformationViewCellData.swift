//
//  InformationViewCellData.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUI
import Localizable

struct InformationViewCellData: InformationViewCellDataType {
    
    let txtHumidity: String = WeatherLanguage.humidity
    let txtPressure: String = WeatherLanguage.pression
    let txtPressureSea: String = WeatherLanguage.pressionSea
    let txtPressureGround: String = WeatherLanguage.pressionGround
    
    let humidty: Int
    let pressure: Int
    let pressureSea: Int
    let pressureGround: Int
    
    init(humidty: Int, pressure: Int, pressureSea: Int, pressureGround: Int) {
        self.humidty = humidty
        self.pressure = pressure
        self.pressureSea = pressureSea
        self.pressureGround = pressureGround
    }
}
