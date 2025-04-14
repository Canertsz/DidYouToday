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
    
    func start(buttonColor: String, answerButtonText: String, activityName: String) {
        let viewController = NotificationPreferenceVC.instantiateViewController()
        let viewModel = NotificationPreferenceVM(view: viewController,
                                                 coordinator: self,
                                                 buttonColor: buttonColor,
                                                 answerButtonText: answerButtonText,
                                                 activityName: activityName)
        
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}

//MARK: - Navigations
extension NotificationPreferenceCoordinator: NotificationPreferenceCoordinatorProtocol {
    func navigateToRecordCreationScreen(buttonColor: String,
                                        answerButtonText: String,
                                        activityName: String,
                                        date: Date?) {
        
        let recordCreationCoordinator = RecordCreationCoordinator(navigationController: navigationController)
        recordCreationCoordinator.start(buttonColor: buttonColor,
                                        answerButtonText: answerButtonText,
                                        activityName: activityName,
                                        date: date)
    }
}
