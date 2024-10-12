//
//  UITableView+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

public extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func register<T: UITableViewHeaderFooterView>(viewType: T.Type, bundle: Bundle? = nil) {
        let className = viewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueReusableView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T ?? T()
    }
}
