import XCTest
@testable import Did_You_Today

final class EditActivityVMUpdateRecordTests: EditActivityVMTestCase {
    
    func testSaveChangesTapped() {
        vm.didActivityNameTextChanged(text: "New Activity")
        vm.didAnswerButtonTextChanged(text: "New Button Text")
        vm.didSelectColor(hex: "#00FF00")
        
        XCTAssertEqual(mockRecord.activityName, "Test Activity")
        XCTAssertEqual(mockRecord.buttonText, "Yes")
        XCTAssertEqual(mockRecord.buttonColor, "#FF0000")
        
        vm.saveChangesTapped()
        
        XCTAssertTrue(mockCoordinator.navigateBackToRecordDetailCalled, "Should navigate back to record detail")
        XCTAssertEqual(mockRecord.activityName, "New Activity", "Activity name should be updated")
        XCTAssertEqual(mockRecord.buttonText, "New Button Text", "Button text should be updated")
        XCTAssertEqual(mockRecord.buttonColor, "#00FF00", "Button color should be updated")
    }
    
    func testSaveChangesWithNoChanges() {
        vm.saveChangesTapped()
        
        XCTAssertTrue(mockCoordinator.navigateBackToRecordDetailCalled, "Should navigate back to record detail")
        XCTAssertEqual(mockRecord.activityName, "Test Activity", "Activity name should remain unchanged")
        XCTAssertEqual(mockRecord.buttonText, "Yes", "Button text should remain unchanged")
        XCTAssertEqual(mockRecord.buttonColor, "#FF0000", "Button color should remain unchanged")
    }
} 
