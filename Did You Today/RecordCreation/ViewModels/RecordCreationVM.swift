//
//  RecordCreationVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 21.03.2025.
//

import Foundation

protocol RecordCreationViewModelProtocol {
    func viewDidLoad()
    func dismissAction()
}

final class RecordCreationVM {
    private weak var view: RecordCreationViewProtocol?
    private let coordinator: RecordCreationCoordinator
    
    private var buttonColor: String!
    private var answerButtonText: String!
    private var activityName: String!
    private var date: Date?
    private var createdRecord: DidYou?
    
    init(
        view: RecordCreationViewProtocol,
        coordinator: RecordCreationCoordinator,
        buttonColor: String,
        answerButtonText: String,
        activityName: String,
        date: Date?
    ) {
        self.view = view
        self.coordinator = coordinator
        self.activityName = activityName
        self.answerButtonText = answerButtonText
        self.activityName = activityName
        self.date = date
        self.buttonColor = buttonColor
    }
}

// MARK: - RecordCreationViewModelProtocol
extension RecordCreationVM: RecordCreationViewModelProtocol {
    func viewDidLoad() {
        view?.setupUI()
        view?.setupAnimation()
        saveToCoreData()
    }
    
    func saveToCoreData() {
        createdRecord = CoreDataService.addCoreData(activityName: activityName, buttonColor: buttonColor, buttonText: answerButtonText, notificationTime: date)
        
        if let record = createdRecord, date != nil {
            NotificationService.shared.requestNotificationPermission { granted in
                if granted {
                    NotificationService.shared.scheduleNotification(for: record)
                } else {
                    print("Notification permission not granted")
                }
            }
        }
        
        NotificationCenter.default.post(name: .didFinishCreatingRecord, object: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismissAction()
        }
    }
    
    func dismissAction() {
        view?.dismissViewController(animated: true, completion: {
            self.coordinator.navigateToHome()
        })
    }
}
