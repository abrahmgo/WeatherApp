//
//  CityWeatherTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Utils

public class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblMinMax: UILabel!
    @IBOutlet weak var background: UIView!
    
    public override func awakeFromNib() {
        background.addRoundShadow()
        backgroundColor = .clear
    }
    
    public func update(model: CityWeatherViewCellDataType) {
        lblTitle.text = model.title
        lblSubtitle.text = model.subtitle
        lblDescription.text = model.description
        lblTemperature.text = model.temperature
        lblMinMax.text = model.minmax
    }
}

public protocol CityWeatherViewCellDataType {
    var title: String { get }
    var subtitle: String { get }
    var description: String { get }
    var temperature: String { get }
    var minmax: String { get }
}

public struct CityWeatherViewCellData: CityWeatherViewCellDataType {
    
    public let title: String
    public let subtitle: String
    public let description: String
    public let temperature: String
    public let minmax: String
    
    public init(title: String, subtitle: String, 
                description: String,
                temperature: String, minmax: String) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.temperature = temperature
        self.minmax = minmax
    }
}
