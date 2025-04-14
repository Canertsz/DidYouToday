//
//  HomeCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func navigateToAddDidYouScreen()
    func navigateToRecordDetailScreen(record: DidYou)
}

final class HomeCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeVC.instantiateViewController()
        let viewModel = HomeVM(view: viewController,
                               coordinator: self)
        
        viewController.viewModel = viewModel
        
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}

// MARK: - Navigations
extension HomeCoordinator: HomeCoordinatorProtocol {
    func navigateToAddDidYouScreen() {
        let addDidYouCoordinator = AddDidYouCoordinator(navigationController: navigationController)
        addDidYouCoordinator.start()
    }
    
    func navigateToRecordDetailScreen(record: DidYou) {
        let recordDetailCoordinator = RecordDetailCoordinator(navigationController: navigationController,
                                                              didYou: record)
        recordDetailCoordinator.start()
    }
}
