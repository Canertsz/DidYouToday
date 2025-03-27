//
//  NotificationPreferenceVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 20.03.2025.
//

import Foundation

protocol NotificationPreferenceViewModelProtocol {
    func viewDidLoad()
    func submitButtonTapped(date: Date)
    func skipButtonTapped()
}

final class NotificationPreferenceVM {
    private weak var view: NotificationPreferenceViewProtocol?
    private let coordinator: NotificationPreferenceCoordinatorProtocol
    
    private var buttonColor: String!
    private var answerButtonText: String!
    private var activityName: String!
    
    init(
        view: NotificationPreferenceViewProtocol,
        coordinator: NotificationPreferenceCoordinatorProtocol,
        buttonColor: String,
        answerButtonText: String,
        activityName: String
    ) {
        self.view = view
        self.coordinator = coordinator
        self.buttonColor = buttonColor
        self.answerButtonText = answerButtonText
        self.activityName = activityName
    }
}

// MARK: - NotificationPreferenceViewModelProtocol
extension NotificationPreferenceVM: NotificationPreferenceViewModelProtocol {
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func submitButtonTapped(date: Date) {
        coordinator.navigateToRecordCreationScreen(buttonColor: buttonColor,
                                                   answerButtonText: answerButtonText,
                                                   activityName: activityName,
                                                   date: date)
    }
    
    func skipButtonTapped() {
        coordinator.navigateToRecordCreationScreen(buttonColor: buttonColor,
                                                   answerButtonText: answerButtonText,
                                                   activityName: activityName,
                                                   date: nil)
    }
}
