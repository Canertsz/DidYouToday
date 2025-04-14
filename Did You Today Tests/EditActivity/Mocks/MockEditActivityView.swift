import XCTest
@testable import Did_You_Today

class MockEditActivityView: EditActivityViewProtocol {
    var setupUICalled = false
    var setupColorPickerViewCalled = false
    var setButtonBackgroundColorCalled = false
    var setActivityNameCalled = false
    var setButtonTextCalled = false
    var showDeleteConfirmationCalled = false
    
    var lastReceivedHexColor: String?
    var lastReceivedDelegate: ColorPickerViewModelDelegate?
    var lastReceivedActivityName: String?
    var lastReceivedButtonText: String?
    var deleteConfirmationCompletion: ((Bool) -> Void)?
    
    func setupUI() {
        setupUICalled = true
    }
    
    func setupColorPickerView(delegate: ColorPickerViewModelDelegate) {
        setupColorPickerViewCalled = true
        lastReceivedDelegate = delegate
    }
    
    func setButtonBackgroundColor(hex: String) {
        setButtonBackgroundColorCalled = true
        lastReceivedHexColor = hex
    }
    
    func setActivityName(_ name: String) {
        setActivityNameCalled = true
        lastReceivedActivityName = name
    }
    
    func setButtonText(_ text: String) {
        setButtonTextCalled = true
        lastReceivedButtonText = text
    }
    
    func showDeleteConfirmation(completion: @escaping (Bool) -> Void) {
        showDeleteConfirmationCalled = true
        deleteConfirmationCompletion = completion
    }
    
    func simulateDeleteConfirmation(confirmed: Bool) {
        deleteConfirmationCompletion?(confirmed)
    }
} 