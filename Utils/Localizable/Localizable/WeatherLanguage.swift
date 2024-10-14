//
//  WeatherLanguage.swift
//  Localizable
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

public struct WeatherLanguage {
    public static let myLocation = LocalizableService.shared.get(key: "myLocation")
    public static let maximum = LocalizableService.shared.get(key: "maximum")
    public static let minimum = LocalizableService.shared.get(key: "minimum")
    public static let humidity = LocalizableService.shared.get(key: "humidity")
    public static let pression = LocalizableService.shared.get(key: "pression")
    public static let pressionSea = LocalizableService.shared.get(key: "pressionSea")
    public static let pressionGround = LocalizableService.shared.get(key: "pressionGround")
    public static let notificationTitle = LocalizableService.shared.get(key: "notificationTitle")
    public static let notificationBody = LocalizableService.shared.get(key: "notificationBody")
    public static let btnAdd = LocalizableService.shared.get(key: "btnAdd")
    public static let btnReady = LocalizableService.shared.get(key: "btnReady")
    public static let btnDelete = LocalizableService.shared.get(key: "btnDelete")
    public static let btnCancel = LocalizableService.shared.get(key: "btnCancel")
    public static let refresh = LocalizableService.shared.get(key: "refresh")
    public static let searchCity = LocalizableService.shared.get(key: "searchCity")
    public static let weather = LocalizableService.shared.get(key: "weather")
    public static let registered = LocalizableService.shared.get(key: "registered")
    public static let localizationMessage = LocalizableService.shared.get(key: "localizationMessage")
    public static let localizationTitle = LocalizableService.shared.get(key: "localizationTitle")
    public static let notificationViewTitle = LocalizableService.shared.get(key: "notificationViewTitle")
    public static let notificationMessage = LocalizableService.shared.get(key: "notificationMessage")
    public static let notificationBtn = LocalizableService.shared.get(key: "notificationBtn")
}
