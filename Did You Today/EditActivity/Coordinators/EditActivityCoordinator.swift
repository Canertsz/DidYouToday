//
//  EditActivityCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 29.03.2025.
//

import Foundation
import UIKit

protocol EditActivityCoordinatorProtocol {
    func navigateBackToRecordDetail()
    func navigateToHome()
}

final class EditActivityCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
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