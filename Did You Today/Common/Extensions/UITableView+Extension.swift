//
//  UICollectionView+Extension.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func dequeue<T: UITableViewCell>(_ cellType: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: cellType.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}

