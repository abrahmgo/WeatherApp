//
//  SpaceTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public class SpaceTableViewCell: UITableViewCell {

    @IBOutlet weak var space: UIView!

    override public func awakeFromNib() {
        backgroundColor = .clear
    }
    
    public func update(model: SpaceViewCellDataType) {
        space.frame.size.height = model.height
        space.backgroundColor = .clear
        self.layoutSubviews()
    }
}

public protocol SpaceViewCellDataType {
    var height: CGFloat { get }
}

public struct SpaceViewCellData: SpaceViewCellDataType {
    
    public let height: CGFloat
    
    public init(height: CGFloat) {
        self.height = height
    }
}
