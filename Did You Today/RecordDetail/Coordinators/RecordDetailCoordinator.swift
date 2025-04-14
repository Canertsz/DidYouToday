//
//  RecordDetailCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation
import UIKit

protocol RecordDetailCoordinatorProtocol: BaseCoordinator {
    func navigateToEditActivity(record: DidYou)
}

final class RecordDetailCoordinator {
    var navigationController: UINavigationController?
    private let didYou: DidYou
    
    init(
        navigationController: UINavigationController?,
        didYou: DidYou
    ) {
        self.navigationController = navigationController
        self.didYou = didYou
    }
    
    func start() {
        let viewController = RecordDetailVC.instantiateViewController()
        let viewModel = RecordDetailVM(
            view: viewController,
            coordinator: self,
            record: didYou
        )
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}

// MARK: - Navigations
extension RecordDetailCoordinator: RecordDetailCoordinatorProtocol {
    func navigateToEditActivity(record: DidYou) {
        let editActivityCoordinator = EditActivityCoordinator(
            navigationController: navigationController,
            record: record
        )
        editActivityCoordinator.start()
    }
}
