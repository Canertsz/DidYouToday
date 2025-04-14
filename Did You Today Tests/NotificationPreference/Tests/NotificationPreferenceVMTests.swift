import XCTest
@testable import Did_You_Today

final class NotificationPreferenceVMTests: NotificationPreferenceVMTestCase {
    func testViewDidLoad() {
        vm.viewDidLoad()
        
        XCTAssertTrue(mockView.setupUICalled, "setupUI should be called")
    }
    
    func testSubmitButtonTapped() {
        let testDate = Date()
        
        vm.submitButtonTapped(date: testDate)
        
        XCTAssertTrue(mockCoordinator.navigateToRecordCreationScreenCalled, "navigateToRecordCreationScreen should be called")
        XCTAssertEqual(mockCoordinator.lastButtonColor, testButtonColor, "Button color should be passed correctly")
        XCTAssertEqual(mockCoordinator.lastAnswerButtonText, testAnswerButtonText, "Answer button text should be passed correctly")
        XCTAssertEqual(mockCoordinator.lastActivityName, testActivityName, "Activity name should be passed correctly")
        XCTAssertEqual(mockCoordinator.lastDate, testDate, "Date should be passed correctly")
    }
    
    func testSkipButtonTapped() {
        vm.skipButtonTapped()
        
        XCTAssertTrue(mockCoordinator.navigateToRecordCreationScreenCalled, "navigateToRecordCreationScreen should be called")
        XCTAssertEqual(mockCoordinator.lastButtonColor, testButtonColor, "Button color should be passed correctly")
        XCTAssertEqual(mockCoordinator.lastAnswerButtonText, testAnswerButtonText, "Answer button text should be passed correctly")
        XCTAssertEqual(mockCoordinator.lastActivityName, testActivityName, "Activity name should be passed correctly")
        XCTAssertNil(mockCoordinator.lastDate, "Date should be nil when skip button is tapped")
    }
} 
