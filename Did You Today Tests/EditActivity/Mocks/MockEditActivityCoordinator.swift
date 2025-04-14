import XCTest
@testable import Did_You_Today

class MockEditActivityCoordinator: EditActivityCoordinatorProtocol {
    var navigateBackToRecordDetailCalled = false
    var navigateToHomeCalled = false
    
    func navigateBackToRecordDetail() {
        navigateBackToRecordDetailCalled = true
    }
    
    func navigateToHome() {
        navigateToHomeCalled = true
    }
} 