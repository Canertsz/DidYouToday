import XCTest
@testable import Did_You_Today

class MockNotificationPreferenceView: NotificationPreferenceViewProtocol {
    var setupUICalled = false
    
    func setupUI() {
        setupUICalled = true
    }
} 