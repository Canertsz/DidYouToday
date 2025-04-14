import UIKit
@testable import Did_You_Today

class MockNotificationService {
    var cancelNotificationWithIdCalled = false
    var lastCanceledNotificationId: String?
    
    static let shared = MockNotificationService()
    
    func cancelNotification(withId id: String) {
        cancelNotificationWithIdCalled = true
        lastCanceledNotificationId = id
    }
} 