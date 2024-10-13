//
//  TitleTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit

public class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override public func awakeFromNib() {
        backgroundColor = .clear
    }
    
    public func update(model: TitleTableViewCellDataType) {
        lblTitle.text = model.title
        lblSubtitle.text = model.subtitle
    }
}

public protocol TitleTableViewCellDataType {
    var title: String { get }
    var subtitle: String { get }
}

public struct TitleTableViewCellData: TitleTableViewCellDataType {
   
    public let title: String
    public let subtitle: String
    
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
