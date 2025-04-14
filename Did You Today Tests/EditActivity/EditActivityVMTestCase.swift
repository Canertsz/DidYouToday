import XCTest
import CoreData
@testable import Did_You_Today

class EditActivityVMTestCase: XCTestCase {
    
    var vm: EditActivityVM!
    var mockView: MockEditActivityView!
    var mockCoordinator: MockEditActivityCoordinator!
    var mockRecord: MockDidYou!
    
    override func setUp() {
        super.setUp()
        mockView = MockEditActivityView()
        mockCoordinator = MockEditActivityCoordinator()
        mockRecord = MockDidYou(
            activityName: "Test Activity",
            buttonText: "Yes",
            buttonColor: "#FF0000"
        )
        
        vm = EditActivityVM(
            view: mockView,
            coordinator: mockCoordinator,
            record: mockRecord
        )
    }
    
    override func tearDown() {
        vm = nil
        mockView = nil
        mockCoordinator = nil
        mockRecord = nil
        
        super.tearDown()
    }
} 
