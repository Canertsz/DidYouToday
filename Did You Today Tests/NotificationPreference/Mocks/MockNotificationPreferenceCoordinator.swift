import XCTest
@testable import Did_You_Today

class MockNotificationPreferenceCoordinator: NotificationPreferenceCoordinatorProtocol {
    var navigateToRecordCreationScreenCalled = false
    var lastButtonColor: String?
    var lastAnswerButtonText: String?
    var lastActivityName: String?
    var lastDate: Date?
    
    func navigateToRecordCreationScreen(buttonColor: String, answerButtonText: String, activityName: String, date: Date?) {
        navigateToRecordCreationScreenCalled = true
        lastButtonColor = buttonColor
        lastAnswerButtonText = answerButtonText
        lastActivityName = activityName
        lastDate = date
    }
} 