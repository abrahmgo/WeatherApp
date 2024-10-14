//
//  CurrentLocationComponents.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import WeatherUI

enum ShowWeatherComponents {
    case headerTitle(data: TitleTableViewCellDataType)
    case temperature(data: TitleNumberViewCellDataType)
    case information(data: InformationViewCellDataType)
    case space(data: SpaceViewCellDataType)
    case icon(data: IconViewCellData)
    case footer(data: FooterViewCellDataType)
}
