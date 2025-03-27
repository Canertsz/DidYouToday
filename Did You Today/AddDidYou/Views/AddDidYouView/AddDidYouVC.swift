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

final class AddDidYouVC: UIViewController {
    var viewModel: AddDidYouViewModelProtocol!

    @IBOutlet weak var buttonBGColorPickerView: ColorPickerView!
    @IBOutlet weak var activityNameInputTextField: UITextField!
    @IBOutlet weak var asnwerButtonTextInputTextField: UITextField!
    @IBOutlet weak var nextPageNavigationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
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

extension AddDidYouVC: AddDidYouViewProtocol {
    func setupUI() {
        nextPageNavigationButton.isEnabled = false
        activityNameInputTextField.addBottomBorder()
        
        asnwerButtonTextInputTextField.attributedPlaceholder = NSAttributedString(
            string: "type here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
    
    func setupColorPickerView(delegate: any ColorPickerViewModelDelegate) {
        buttonBGColorPickerView.viewModel = ColorPickerViewModel(delegate: delegate)
    }
    
    func setButtonBackgroundColor(hex: String) {
        let backgroundColor = UIColor.init(hexCode: hex, alpha: 1)
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
