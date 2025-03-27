//
//  UICollectionView+Extension.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cellType: T.Type, indexPath: IndexPath) -> T {
        let identity = String.init(describing: cellType.self)
        return dequeueReusableCell(withReuseIdentifier: identity, for: indexPath) as! T
    }
}
