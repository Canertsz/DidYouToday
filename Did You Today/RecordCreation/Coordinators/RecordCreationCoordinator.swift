//
//  RecordCreationCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 21.03.2025.
//

import Foundation
import UIKit

protocol RecordCreationCoordinatorProtocol {
    func navigateToHome()
}

final class RecordCreationCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        
        

    }
}

// MARK: - Navigations
extension RecordCreationCoordinator: RecordCreationCoordinatorProtocol {
    func navigateToHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
