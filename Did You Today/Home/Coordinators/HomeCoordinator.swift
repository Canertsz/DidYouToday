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
        let viewController = AddDidYouVC.instantiateViewController()
        let coordinator = AddDidYouCoordinator(navigationController: navigationController)
        let viewModel = AddDidYouVM(
            view: viewController,
            coordinator: coordinator
        )
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
    
    func navigateToRecordDetailScreen(record: DidYou) {
        let viewController = RecordDetailVC.instantiateViewController()
        let coordinator = RecordDetailCoordinator(navigationController: navigationController)
        let viewModel = RecordDetailVM(
            view: viewController,
            coordinator: coordinator,
            record: record
        )
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
