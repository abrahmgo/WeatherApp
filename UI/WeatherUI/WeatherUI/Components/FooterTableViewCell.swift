//
//  FooterTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit

public class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFooter: UILabel!
    override public  func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    public func update(model: FooterViewCellDataType) {
        lblFooter.text = model.text
        lblFooter.textColor = model.textColor
    }
}

public protocol FooterViewCellDataType {
    var text: String { get }
    var textColor: UIColor { get }
}

public struct FooterViewCellData: FooterViewCellDataType {
    
    public let text: String
    public let textColor: UIColor
    
    public init(text: String, textColor: UIColor = .black) {
        self.text = text
        self.textColor = textColor
    }
}
