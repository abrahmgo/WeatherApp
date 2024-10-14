//
//  InformationTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    
    
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblPressureSea: UILabel!
    @IBOutlet weak var lblPressureGround: UILabel!
    
    override public func awakeFromNib() {
        backgroundColor = .clear
    }
    
    public func update(model: InformationViewCellDataType) {
        lblTitle1.text = model.txtHumidity
        lblTitle2.text = model.txtPressure
        lblTitle3.text = model.txtPressureSea
        lblTitle4.text = model.txtPressureGround
        
        lblHumidity.text = "\(model.humidty)%"
        lblPressure.text = "\(model.pressure) hPa"
        lblPressureSea.text = "\(model.pressureSea) hPa"
        lblPressureGround.text = "\(model.pressureGround) hPa"
    }
}

public protocol InformationViewCellDataType {
    
    var txtHumidity: String { get }
    var txtPressure: String { get }
    var txtPressureSea: String { get}
    var txtPressureGround: String { get}
    
    var humidty: Int { get }
    var pressure: Int { get }
    var pressureSea: Int { get}
    var pressureGround: Int { get}
}
