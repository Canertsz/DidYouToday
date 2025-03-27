//
//  RecordDetailCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation
import UIKit

protocol RecordDetailCoordinatorProtocol {
    func navigateToAddDidYouScreen()
}

final class RecordDetailCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - Navigations
extension RecordDetailCoordinator: RecordDetailCoordinatorProtocol {
    func navigateToAddDidYouScreen() {
        
    }
}
