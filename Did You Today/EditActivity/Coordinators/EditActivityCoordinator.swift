//
//  EditActivityCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 29.03.2025.
//

import Foundation
import UIKit

protocol EditActivityCoordinatorProtocol: BaseCoordinator {
    func navigateBackToRecordDetail()
    func navigateToHome()
}

final class EditActivityCoordinator {
    var navigationController: UINavigationController?
    private let record: DidYou
    
    init(navigationController: UINavigationController?, record: DidYou) {
        self.navigationController = navigationController
        self.record = record
    }
    
    func start() {
        let viewController = EditActivityVC.instantiateViewController()
        let viewModel = EditActivityVM(
            view: viewController,
            coordinator: self,
            record: record
        )
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Navigations
extension EditActivityCoordinator: EditActivityCoordinatorProtocol {
    func navigateBackToRecordDetail() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToHome() {
        navigationController?.popToRootViewController(animated: true)
    }
} 
