//
//  EditActivityVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 29.03.2025.
//

import UIKit

protocol EditActivityViewProtocol: AnyObject {
    func setupUI()
    func setupColorPickerView(delegate: ColorPickerViewModelDelegate)
    func setButtonBackgroundColor(hex: String)
    func setActivityName(_ name: String)
    func setButtonText(_ text: String)
    func showDeleteConfirmation(completion: @escaping (Bool) -> Void)
}

final class EditActivityVC: UIViewController {
    var viewModel: EditActivityViewModelProtocol!
    
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var answerButtonTextField: UITextField!
    @IBOutlet weak var buttonColorPickerView: ColorPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupTextFieldObservers()
        setupTapGestureToDismissKeyboard()
        setupTextFieldDelegates()
    }
    
    private func setupTextFieldDelegates() {
        activityNameTextField.delegate = self
        answerButtonTextField.delegate = self
    }
    
    private func setupTextFieldObservers() {
        activityNameTextField.addTarget(self, action: #selector(didActivityNameTextChanged), for: .editingChanged)
        answerButtonTextField.addTarget(self, action: #selector(didAnswerButtonTextChanged), for: .editingChanged)
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: Any) {
        viewModel.saveChangesTapped()
    }
    
    @IBAction func deleteActivityButtonTapped(_ sender: Any) {
        viewModel.deleteActivityTapped()
    }
}

// MARK: - Keyboard Actions
extension EditActivityVC {
    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: -  Textfield Changes
extension EditActivityVC {
    @objc private func didActivityNameTextChanged() {
        viewModel.didActivityNameTextChanged(text: activityNameTextField.text)
    }
    
    @objc private func didAnswerButtonTextChanged() {
        viewModel.didAnswerButtonTextChanged(text: answerButtonTextField.text)
    }
}

// MARK: - EditActivityViewProtocol
extension EditActivityVC: EditActivityViewProtocol {
    func setupUI() {
        title = "Edit Activity"
        
        activityNameTextField.addBottomBorder()
        
        answerButtonTextField.layer.cornerRadius = 6.0
        answerButtonTextField.clipsToBounds = true
        answerButtonTextField.textColor = .white
    }
    
    func setupColorPickerView(delegate: ColorPickerViewModelDelegate) {
        buttonColorPickerView.viewModel = ColorPickerViewModel(delegate: delegate)
    }
    
    func setButtonBackgroundColor(hex: String) {
        let backgroundColor = UIColor(hex: hex)
        
        answerButtonTextField.backgroundColor = backgroundColor
        answerButtonTextField.layer.cornerRadius = 6.0
        answerButtonTextField.clipsToBounds = true
        answerButtonTextField.textColor = .white
    }
    
    func setActivityName(_ name: String) {
        activityNameTextField.text = name
    }
    
    func setButtonText(_ text: String) {
        answerButtonTextField.text = text
    }
    
    func showDeleteConfirmation(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: "Delete Activity",
            message: "Are you sure you want to delete this activity? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        })
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion(true)
        })
        
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension EditActivityVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == activityNameTextField {
            answerButtonTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension EditActivityVC: StoryboardInstantiable {
    static var storyboardName: String { "EditActivity" }
    static var identifier: String { "EditActivityVC" }
} 
