//
//  AppCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.navigationController = navigationController
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
