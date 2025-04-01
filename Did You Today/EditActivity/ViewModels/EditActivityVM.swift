//
//  EditActivityVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 29.03.2025.
//

import Foundation
import UIKit

protocol EditActivityViewModelProtocol {
    func viewDidLoad()
    func didActivityNameTextChanged(text: String?)
    func didAnswerButtonTextChanged(text: String?)
    func saveChangesTapped()
    func deleteActivityTapped()
}

final class EditActivityVM {
    private weak var view: EditActivityViewProtocol?
    private let coordinator: EditActivityCoordinatorProtocol
    private let record: DidYou
    
    private var activityName: String
    private var buttonText: String
    private var buttonColor: String
    
    init(view: EditActivityViewProtocol, coordinator: EditActivityCoordinatorProtocol, record: DidYou) {
        self.view = view
        self.coordinator = coordinator
        self.record = record
        
        // Initialize with current record values
        self.activityName = record.activityName ?? ""
        self.buttonText = record.buttonText ?? ""
        self.buttonColor = record.buttonColor ?? "#000000"
    }
    
    private func cancelNotificationForRecord(_ record: DidYou) {
        guard let activityName = record.activityName else { return }
        let notificationId = "didyou-\(activityName.lowercased().replacingOccurrences(of: " ", with: "-"))"
        NotificationService.shared.cancelNotification(withId: notificationId)
    }
    
    private func updateRecord() {
        record.activityName = activityName
        record.buttonText = buttonText
        record.buttonColor = buttonColor
        
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
            
            coordinator.navigateBackToRecordDetail()
        } catch {
            print("Error saving record: \(error)")
        }
    }
}

// MARK: - ColorPickerViewModelDelegate
extension EditActivityVM: ColorPickerViewModelDelegate {
    func didSelectColor(hex: String) {
        buttonColor = hex
        view?.setButtonBackgroundColor(hex: hex)
    }
}

// MARK: - EditActivityViewModelProtocol
extension EditActivityVM: EditActivityViewModelProtocol {
    func viewDidLoad() {
        view?.setupUI()
        view?.setupColorPickerView(delegate: self)
        
        view?.setActivityName(activityName)
        view?.setButtonText(buttonText)
        view?.setButtonBackgroundColor(hex: buttonColor)
    }
    
    func didActivityNameTextChanged(text: String?) {
        guard let text else { return }
        activityName = text
    }
    
    func didAnswerButtonTextChanged(text: String?) {
        guard let text else { return }
        buttonText = text
    }
    
    func saveChangesTapped() {
        updateRecord()
    }
    
    func deleteActivityTapped() {
        view?.showDeleteConfirmation { [weak self] confirmed in
            guard let self, confirmed else { return }
            
            self.cancelNotificationForRecord(self.record)
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(self.record)
            
            do {
                try context.save()
                self.coordinator.navigateToHome()
            } catch {
                print("Error deleting record: \(error)")
            }
        }
    }
} 
