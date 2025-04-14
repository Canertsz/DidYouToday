import XCTest
import CoreData
@testable import Did_You_Today

class MockContext: NSManagedObjectContext {
    var deleteCalled = false
    var deletedObject: NSManagedObject?
    var saveCalled = false
    
    override func delete(_ object: NSManagedObject) {
        deleteCalled = true
        deletedObject = object
    }
    
    override func save() throws {
        saveCalled = true
    }
}

final class EditActivityVMDeleteTests: EditActivityVMTestCase {
    var mockContext: MockContext!
    
    override func setUp() {
        super.setUp()
        
        // Setup mock context
        mockContext = MockContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    func testDeleteActivityTapped_Confirmed() {
        let confirmDelete = true
        
        vm.deleteActivityTapped()
        
        XCTAssertTrue(mockView.showDeleteConfirmationCalled, "Show delete confirmation should be called")
        
        // Simulate user confirming deletion
        mockView.simulateDeleteConfirmation(confirmed: confirmDelete)
        
        XCTAssertTrue(mockCoordinator.navigateToHomeCalled, "Should navigate to home screen")
    }
    
    func testDeleteActivityTapped_Canceled() {
        let confirmDelete = false
        
        vm.deleteActivityTapped()
        
        XCTAssertTrue(mockView.showDeleteConfirmationCalled, "Show delete confirmation should be called")
        
        // Simulate user canceling deletion
        mockView.simulateDeleteConfirmation(confirmed: confirmDelete)
        
        XCTAssertFalse(mockCoordinator.navigateToHomeCalled, "Should not navigate to home screen")
    }
} 
