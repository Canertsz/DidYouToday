//
//  StoryboardInstantiable.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 8.03.2025.
//
import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var identifier: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiateViewController() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self
        guard let viewController else {
            fatalError("\(identifier) couldnt instantiaed from \(storyboardName)")
        }
        return viewController
            
    }
}
