//
//  AddDidYouVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import UIKit

protocol AddDidYouViewModelProtocol {
    func viewDidLoad()
    func didActivityNameTextChanged(text: String?)
    func didAnswerButtonTextChanged(text: String?)
    func nextPageButtonTapped()
}

final class AddDidYouVM {
    private weak var view: AddDidYouViewProtocol?
    private let coordinator: AddDidYouCoordinatorProtocol
    
    private var buttonColor: String?
    private var answerButtonText: String?
    private var activityName: String?
    
    init(
        view: AddDidYouViewProtocol,
        coordinator: AddDidYouCoordinatorProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
    }
    
    private func didFormChanged() {
        let isAnswerButtonTextValid = !(answerButtonText?.isEmpty ?? true)
        let isActivityNameValid = !(activityName?.isEmpty ?? true)
        let isFormValid = isAnswerButtonTextValid && isActivityNameValid
        view?.setEnableNextPageNavigation(isEnabled: isFormValid)
    }
}

// MARK: - ColorPickerViewModelDelegate
extension AddDidYouVM: ColorPickerViewModelDelegate {
    func didSelectColor(hex: String) {
        buttonColor = hex
        view?.setButtonBackgroundColor(hex: hex)
    }
}

// MARK: - AddDidYouViewModelProtocol
extension AddDidYouVM: AddDidYouViewModelProtocol {
    func viewDidLoad() {
        view?.setupUI()
        view?.setupColorPickerView(delegate: self)
        view?.observeTextfields()
    }
    
    func didActivityNameTextChanged(text: String?) {
        activityName = text
        didFormChanged()
    }
    
    func didAnswerButtonTextChanged(text: String?) {
        answerButtonText = text
        didFormChanged()
    }
    
    func nextPageButtonTapped() {
        guard
            let answerButtonText,
            let activityName,
            let buttonColor
        else { return }
        
        coordinator.navigateToNotificationPreferenceScreen(
            buttonColor: buttonColor,
            answerButtonText: answerButtonText,
            activityName: activityName
        )
    }
}
