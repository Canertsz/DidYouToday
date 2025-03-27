//
//  NotificationPreferenceCoordinator.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 20.03.2025.
//

import Foundation
import UIKit

protocol NotificationPreferenceCoordinatorProtocol {
    func navigateToRecordCreationScreen(buttonColor: String,
                                        answerButtonText: String,
                                        activityName: String,
                                        date: Date?)
}

final class NotificationPreferenceCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

//MARK: - Navigations
extension NotificationPreferenceCoordinator: NotificationPreferenceCoordinatorProtocol {
    func navigateToRecordCreationScreen(buttonColor: String,
                                        answerButtonText: String,
                                        activityName: String,
                                        date: Date?) {
        let viewController = RecordCreationVC.instantiateViewController()
        let coordinator = RecordCreationCoordinator(navigationController: navigationController)
        
        let viewModel = RecordCreationVM(
            view: viewController,
            coordinator: coordinator,
            buttonColor: buttonColor,
            answerButtonText: answerButtonText,
            activityName: activityName,
            date: date
        )
        
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .fullScreen
        
        navigationController?.present(viewController,
                                                 animated: true)
    }
}
