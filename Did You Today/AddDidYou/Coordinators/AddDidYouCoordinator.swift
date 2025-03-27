//
//  HomeCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation
import UIKit

protocol AddDidYouCoordinatorProtocol {
    func navigateToNotificationPreferenceScreen(buttonColor: String,
                                                answerButtonText: String,
                                                activityName: String)
}

final class AddDidYouCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension AddDidYouCoordinator: AddDidYouCoordinatorProtocol {
    func navigateToNotificationPreferenceScreen(buttonColor: String, answerButtonText: String, activityName: String) {
        let viewController = NotificationPreferenceVC.instantiateViewController()
        let coordinator = NotificationPreferenceCoordinator(navigationController: navigationController)
        
        let viewModel = NotificationPreferenceVM(
            view: viewController,
            coordinator: coordinator,
            buttonColor: buttonColor,
            answerButtonText: answerButtonText,
            activityName: activityName
        )
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
