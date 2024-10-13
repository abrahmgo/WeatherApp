//
//  TitleNumberTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public class TitleNumberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    override public func awakeFromNib() {
        backgroundColor = .clear
    }
    
    public func update(model: TitleNumberViewCellDataType) {
        lblTop.text = model.number
        lblTitle.text = model.title
        lblSubtitle.text = model.subtitle
    }
}

public protocol TitleNumberViewCellDataType {
    var number: String { get }
    var title: String { get }
    var subtitle: String { get}
}

public struct TitleNumberViewCellData: TitleNumberViewCellDataType {
    
    public let number: String
    public let title: String
    public let subtitle: String
    
    public init(number: String, title: String, subtitle: String) {
        self.number = number
        self.title = title
        self.subtitle = subtitle
    }
}
