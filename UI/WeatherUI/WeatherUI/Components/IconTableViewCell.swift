//
//  IconTableViewCell.swift
//  WeatherUI
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public class IconTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override public func awakeFromNib() {
        backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.5)
    }
    
    public func update(model: IconViewCellDataType) {
        imgView.image = model.image
    }
}

public protocol IconViewCellDataType {
    var image: UIImage? { get }
}

public struct IconViewCellData: IconViewCellDataType {
    
    public let image: UIImage?
    
    public init(image: UIImage?) {
        self.image = image
    }
}
