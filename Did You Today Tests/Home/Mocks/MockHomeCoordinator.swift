import XCTest
@testable import Did_You_Today

class MockHomeCoordinator: HomeCoordinatorProtocol {
    var navigateToAddDidYouScreenCalled = false
    var navigateToRecordDetailScreenCalled = false
    var lastRecord: DidYou?
    
    func navigateToAddDidYouScreen() {
        navigateToAddDidYouScreenCalled = true
    }
    
    func navigateToRecordDetailScreen(record: DidYou) {
        navigateToRecordDetailScreenCalled = true
        lastRecord = record
    }
} 