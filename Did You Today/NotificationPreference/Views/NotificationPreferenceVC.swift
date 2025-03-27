//
//  NotificationPreferenceVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 20.03.2025.
//

import UIKit

protocol NotificationPreferenceViewProtocol: AnyObject {
    func setupUI()
}

final class NotificationPreferenceVC: UIViewController {
    
    var viewModel: NotificationPreferenceViewModelProtocol!

    @IBOutlet weak var notificationTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        viewModel.submitButtonTapped(date: notificationTimePicker.date)
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        viewModel.skipButtonTapped()
    }
    
}

// MARK: - NotificationPreferenceViewProtocol
extension NotificationPreferenceVC: NotificationPreferenceViewProtocol {
    func setupUI() {
        
    }
}

extension NotificationPreferenceVC: StoryboardInstantiable {
    static var storyboardName: String { "NotificationPreference" }
    static var identifier: String { "NotificationPreferenceVC" }
}
