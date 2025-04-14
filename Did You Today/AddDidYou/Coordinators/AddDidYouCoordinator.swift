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
    
    func start() {
        let viewController = AddDidYouVC.instantiateViewController()
        let viewModel = AddDidYouVM(view: viewController,
                                    coordinator: self)
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}

extension AddDidYouCoordinator: AddDidYouCoordinatorProtocol {
    func navigateToNotificationPreferenceScreen(buttonColor: String, answerButtonText: String, activityName: String) {
        let notificationPreferenceCoordinator = NotificationPreferenceCoordinator(navigationController: navigationController)
        notificationPreferenceCoordinator.start(buttonColor: buttonColor, answerButtonText: answerButtonText, activityName: activityName)
    }
}
