//
//  AddDidYouVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import UIKit

protocol AddDidYouViewProtocol: AnyObject {
    func setupUI()
    func setButtonBackgroundColor(hex: String)
    func setupColorPickerView(delegate: ColorPickerViewModelDelegate)
    func enableNextPageNavigation()
    func observeTextfields()
}

extension AddDidYouVC {
    enum constants {
        static let answerButtonTextFieldPlaceholder = "type here..."
        static let answerButtonBGColorAlphaValue = 1.0
    }
}

final class AddDidYouVC: UIViewController {
    var viewModel: AddDidYouViewModelProtocol!

    @IBOutlet weak var buttonBGColorPickerView: ColorPickerView!
    @IBOutlet weak var activityNameInputTextField: UITextField!
    @IBOutlet weak var asnwerButtonTextInputTextField: UITextField!
    @IBOutlet weak var nextPageNavigationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupTapGestureToDismissKeyboard()
        setupTextFieldDelegates()
    }
    
    private func setupTapGestureToDismissKeyboard() {
        // Add tap gesture recognizer to dismiss keyboard when tapping outside text fields
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allow other touch events to still work
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextFieldDelegates() {
        activityNameInputTextField.delegate = self
        asnwerButtonTextInputTextField.delegate = self
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func didActivityNameTextChanged() {
        viewModel.didActivityNameTextChanged(text: activityNameInputTextField.text)
    }
    
    @objc
    private func didAnswerButtonTextChanged() {
        viewModel.didAnswerButtonTextChanged(text: asnwerButtonTextInputTextField.text)
    }
    
    @IBAction func nextPageButtonAction(_ sender: Any) {
        viewModel.nextPageButtonTapped()
    }
}

// MARK: - UITextFieldDelegate
extension AddDidYouVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // If activity name field is active, move to answer button field
        if textField == activityNameInputTextField {
            asnwerButtonTextInputTextField.becomeFirstResponder()
        } else {
            // Otherwise, dismiss keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - AddDidYouViewProtocol
extension AddDidYouVC: AddDidYouViewProtocol {
    func setupUI() {
        nextPageNavigationButton.isEnabled = false
        // UITextField+Extension method
        activityNameInputTextField.addBottomBorder()
        
        asnwerButtonTextInputTextField.attributedPlaceholder = NSAttributedString(
            string: constants.answerButtonTextFieldPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
    
    func setupColorPickerView(delegate: any ColorPickerViewModelDelegate) {
        buttonBGColorPickerView.viewModel = ColorPickerViewModel(delegate: delegate)
    }
    
    func setButtonBackgroundColor(hex: String) {
        let backgroundColor = UIColor.init(hex: hex)
        asnwerButtonTextInputTextField.backgroundColor = backgroundColor
    }
    
    func observeTextfields() {
        activityNameInputTextField.addTarget(self, action: #selector(self.didActivityNameTextChanged), for: .editingChanged)
        asnwerButtonTextInputTextField.addTarget(self, action: #selector(self.didAnswerButtonTextChanged), for: .editingChanged)
    }
    
    func enableNextPageNavigation() {
        nextPageNavigationButton.isEnabled = true
    }
    
}

extension AddDidYouVC: StoryboardInstantiable {
    static var storyboardName: String { "AddDidYou" }
    static var identifier: String { "AddDidYouVC" }
}
