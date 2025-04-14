import XCTest
@testable import Did_You_Today

final class HomeVMNavigationTests: HomeVMTestCase {
    
    func testAddDidYouButtonTapped() {
        vm.addDidYouButtonTapped()
        
        XCTAssertTrue(mockCoordinator.navigateToAddDidYouScreenCalled, "Should navigate to Add Did You screen")
    }
    
    func testNavigateToRecordDetail() {
        let record = createMockRecord(id: 1)
        
        vm.navigateToRecordDetail(record)
        
        XCTAssertTrue(mockCoordinator.navigateToRecordDetailScreenCalled, "Should navigate to Record Detail screen")
        XCTAssertEqual(mockCoordinator.lastRecord?.activityName, record.activityName, "The correct record should be passed to the coordinator")
    }
    
    func testDidSelectRecordWithValidIndex() {
        let record1 = createMockRecord(id: 1)
        let record2 = createMockRecord(id: 2)
        mockCoreDataService.mockRecords = [record1, record2]
        
        vm.refreshData()
        vm.didSelectRecord(at: IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(mockCoordinator.navigateToRecordDetailScreenCalled, "Should navigate to Record Detail screen")
        XCTAssertEqual(mockCoordinator.lastRecord?.activityName, "Test Activity 2", "The correct record should be passed to the coordinator")
    }
    
    func testDidSelectRecordWithInvalidIndex() {
        let record = createMockRecord(id: 1)
        mockCoreDataService.mockRecords = [record]
        
        vm.refreshData()
        vm.didSelectRecord(at: IndexPath(row: 1, section: 0))
        
        XCTAssertFalse(mockCoordinator.navigateToRecordDetailScreenCalled, "Should not navigate with invalid index")
    }
} 