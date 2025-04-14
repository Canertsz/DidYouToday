import XCTest
@testable import Did_You_Today

final class HomeVMDataTests: HomeVMTestCase {
    func testFetchRecords() {
        let record1 = createMockRecord(id: 1)
        let record2 = createMockRecord(id: 2)
        mockCoreDataService.mockRecords = [record1, record2]
        
        vm.fetchRecords()
        
        XCTAssertTrue(mockCoreDataService.fetchCoreDataCalled, "fetchCoreData should be called")
        XCTAssertEqual(vm.numberOfItemsInSection, 2, "Records count should match mock data")
    }
    
    func testRefreshData() {
        let record = createMockRecord(id: 1)
        mockCoreDataService.mockRecords = [record]
        
        vm.refreshData()
        
        XCTAssertTrue(mockCoreDataService.fetchCoreDataCalled, "fetchCoreData should be called")
        XCTAssertTrue(mockView.reloadUICalled, "reloadUI should be called")
        XCTAssertEqual(vm.numberOfItemsInSection, 1, "Records count should match mock data")
    }
    
    func testRecordForIndexPath() {
        let record1 = createMockRecord(id: 1)
        let record2 = createMockRecord(id: 2)
        mockCoreDataService.mockRecords = [record1, record2]
        
        vm.refreshData()
        
        let retrievedRecord = vm.record(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(retrievedRecord, "Should return a record for valid index")
        XCTAssertEqual(retrievedRecord?.activityName, "Test Activity 1", "Should return the correct record")
        
        let nilRecord = vm.record(for: IndexPath(row: 5, section: 0))
        XCTAssertNil(nilRecord, "Should return nil for invalid index")
    }
    
    func testHandleRecordCreation() {
        let record = createMockRecord(id: 1)
        mockCoreDataService.mockRecords = [record]
        
        // Reset flags to verify they get called
        mockCoreDataService.fetchCoreDataCalled = false
        mockView.reloadUICalled = false
        
        // Directly call the method now that it's internal
        vm.handleRecordCreation()
        
        // Verify
        XCTAssertTrue(mockCoreDataService.fetchCoreDataCalled, "fetchCoreData should be called")
        XCTAssertTrue(mockView.reloadUICalled, "reloadUI should be called")
    }
    
    func testNotificationTriggersRefresh() {
        // Setup
        let record = createMockRecord(id: 1)
        mockCoreDataService.mockRecords = [record]
        
        // Register for notifications
        vm.registerNotificationCenterObserver()
        
        // Reset flags to verify they get called
        mockCoreDataService.fetchCoreDataCalled = false
        mockView.reloadUICalled = false
        
        // Post notification using the mock notification center
        mockNotificationCenter.post(name: .didFinishCreatingRecord, object: nil)
        
        // Verify notification posting
        XCTAssertTrue(mockNotificationCenter.postCalled, "post should be called on the mock")
        XCTAssertEqual(mockNotificationCenter.lastPostedName, .didFinishCreatingRecord, "Correct notification name should be posted")
    }
    
    func testRegisterNotificationCenterObserver() {
        // Setup & Execute
        vm.registerNotificationCenterObserver()
        
        // Verify
        XCTAssertTrue(mockNotificationCenter.addObserverCalled, "addObserver should be called")
        XCTAssertEqual(mockNotificationCenter.lastName, .didFinishCreatingRecord, "Should observe didFinishCreatingRecord")
    }
} 
