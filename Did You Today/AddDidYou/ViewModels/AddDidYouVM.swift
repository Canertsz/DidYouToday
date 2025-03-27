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
    
    private var buttonColor: String = "#000000"
    private var answerButtonText: String = ""
    private var activityName: String = ""
    
    init(
        view: AddDidYouViewProtocol,
        coordinator: AddDidYouCoordinatorProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
    }
    
    private func didFormChanged() {
        if !answerButtonText.isEmpty && !activityName.isEmpty  {
            view?.enableNextPageNavigation()
        }
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
        guard let text else { return }
        activityName = text
        didFormChanged()
    }
    
    func didAnswerButtonTextChanged(text: String?) {
        guard let text else { return }
        answerButtonText = text
        didFormChanged()
    }
    
    func nextPageButtonTapped() {
        coordinator.navigateToNotificationPreferenceScreen(buttonColor: buttonColor,
                                                           answerButtonText: answerButtonText,
                                                           activityName: activityName)
    }
}

// MARK: -
extension AddDidYouVM {
    
}
