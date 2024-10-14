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
    }
}

public protocol FooterViewCellDataType {
    var text: String { get }
}

public struct FooterViewCellData: FooterViewCellDataType {
    
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
}
