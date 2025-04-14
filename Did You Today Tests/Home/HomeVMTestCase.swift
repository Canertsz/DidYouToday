import XCTest
import CoreData
@testable import Did_You_Today

class HomeVMTestCase: XCTestCase {
    var vm: HomeVM!
    var mockView: MockHomeView!
    var mockCoordinator: MockHomeCoordinator!
    var mockCoreDataService: MockCoreDataService!
    var mockNotificationCenter: MockNotificationCenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockCoordinator = MockHomeCoordinator()
        mockCoreDataService = MockCoreDataService()
        mockNotificationCenter = MockNotificationCenter()
        
        vm = HomeVM(
            view: mockView,
            coordinator: mockCoordinator,
            coreDataService: mockCoreDataService,
            notificationCenter: mockNotificationCenter
        )
    }
    
    override func tearDown() {
        mockNotificationCenter.removeObserver(vm)
        
        vm = nil
        mockView = nil
        mockCoordinator = nil
        mockCoreDataService = nil
        mockNotificationCenter = nil
        
        super.tearDown()
    }
    
    func createMockRecord(id: Int) -> HomeDidYouMock {
        let record = HomeDidYouMock(
            activityName: "Test Activity \(id)",
            buttonText: "Yes \(id)",
            buttonColor: "#FF000\(id)"
        )
        return record
    }
} 
