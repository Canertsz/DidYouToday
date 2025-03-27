//
//  BaseCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit

protocol BaseCoordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
}
