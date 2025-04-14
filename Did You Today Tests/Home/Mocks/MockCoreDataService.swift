import XCTest
import CoreData
@testable import Did_You_Today

class MockCoreDataService: CoreDataServiceProtocol {
    var fetchCoreDataCalled = false
    var addCoreDataCalled = false
    var deleteCoreDataCalled = false
    var getRecordCalled = false
    
    var mockRecords: [HomeDidYouMock] = []
    var mockAddedRecord: HomeDidYouMock?
    var mockDeletedIndex: Int?
    var mockDeletedItems: [DidYou]?
    var mockReturnedRecord: HomeDidYouMock?
    
    func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void) {
        fetchCoreDataCalled = true
        onSuccess(mockRecords)
    }
    
    func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou? {
        addCoreDataCalled = true
        let record = HomeDidYouMock(
            activityName: activityName,
            buttonText: buttonText,
            buttonColor: buttonColor
        )
        mockAddedRecord = record
        return record
    }
    
    func deleteCoreData(indexPath: Int, items: [DidYou]) {
        deleteCoreDataCalled = true
        mockDeletedIndex = indexPath
        mockDeletedItems = items
    }
    
    func getRecord(by objectID: NSManagedObjectID) -> DidYou? {
        getRecordCalled = true
        return mockReturnedRecord
    }
    
    func reset() {
        fetchCoreDataCalled = false
        addCoreDataCalled = false
        deleteCoreDataCalled = false
        getRecordCalled = false
        
        mockRecords = []
        mockAddedRecord = nil
        mockDeletedIndex = nil
        mockDeletedItems = nil
        mockReturnedRecord = nil
    }
} 
