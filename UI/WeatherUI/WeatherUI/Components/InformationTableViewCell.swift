//
//  InformationTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblPressureSea: UILabel!
    @IBOutlet weak var lblPressureGround: UILabel!
    
    override public func awakeFromNib() {
        backgroundColor = .clear
    }
    
    public func update(model: InformationViewCellDataType) {
        lblHumidity.text = "\(model.humidty)%"
        lblPressure.text = "\(model.pressure) hPa"
        lblPressureSea.text = "\(model.pressureSea) hPa"
        lblPressureGround.text = "\(model.pressureGround) hPa"
    }
}

public protocol InformationViewCellDataType {
    var humidty: Int { get }
    var pressure: Int { get }
    var pressureSea: Int { get}
    var pressureGround: Int { get}
}

public struct InformationViewCellData: InformationViewCellDataType {
    
    public let humidty: Int
    public let pressure: Int
    public let pressureSea: Int
    public let pressureGround: Int
    
    public init(humidty: Int, pressure: Int, pressureSea: Int, pressureGround: Int) {
        self.humidty = humidty
        self.pressure = pressure
        self.pressureSea = pressureSea
        self.pressureGround = pressureGround
    }
}
