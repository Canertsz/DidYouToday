import XCTest
@testable import Did_You_Today

class NotificationPreferenceVMTestCase: XCTestCase {
    var vm: NotificationPreferenceVM!
    var mockView: MockNotificationPreferenceView!
    var mockCoordinator: MockNotificationPreferenceCoordinator!
    
    // Test data
    let testButtonColor = "#FF0000"
    let testAnswerButtonText = "Yes"
    let testActivityName = "Test Activity"
    
    override func setUp() {
        super.setUp()
        mockView = MockNotificationPreferenceView()
        mockCoordinator = MockNotificationPreferenceCoordinator()
        
        vm = NotificationPreferenceVM(
            view: mockView,
            coordinator: mockCoordinator,
            buttonColor: testButtonColor,
            answerButtonText: testAnswerButtonText,
            activityName: testActivityName
        )
    }
    
    override func tearDown() {
        vm = nil
        mockView = nil
        mockCoordinator = nil
        super.tearDown()
    }
} 