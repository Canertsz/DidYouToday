//
//  RecordDetailCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation
import UIKit

protocol RecordDetailCoordinatorProtocol {
    func navigateToEditActivity(record: DidYou)
}

final class RecordDetailCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - Navigations
extension RecordDetailCoordinator: RecordDetailCoordinatorProtocol {
    func navigateToEditActivity(record: DidYou) {
        let viewController = EditActivityVC.instantiateViewController()
        let coordinator = EditActivityCoordinator(navigationController: navigationController)
        
        let viewModel = EditActivityVM(
            view: viewController,
            coordinator: coordinator,
            record: record
        )
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
