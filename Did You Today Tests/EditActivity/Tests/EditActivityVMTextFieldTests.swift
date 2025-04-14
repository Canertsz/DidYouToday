import XCTest
@testable import Did_You_Today

final class EditActivityVMTextFieldTests: EditActivityVMTestCase {
    
    // MARK: - Activity Name
    func testDidActivityNameTextChanged_WithValidText() {
        let updatedText = "Updated Activity"
        
        vm.didActivityNameTextChanged(text: updatedText)
        
        XCTAssertEqual(mockRecord.activityName, "Test Activity", "Record should not be updated until save is called")
        
        vm.saveChangesTapped()
        
        XCTAssertEqual(mockRecord.activityName, updatedText, "Record should be updated with new activity name")
    }
    
    func testDidActivityNameTextChanged_WithNilText() {
        vm.didActivityNameTextChanged(text: nil)
        
        XCTAssertEqual(mockRecord.activityName, "Test Activity", "Activity name should not change")
        
        vm.saveChangesTapped()
        
        XCTAssertEqual(mockRecord.activityName, "Test Activity", "Activity name should not change")
    }
    
    // MARK: - Button Text
    func testDidAnswerButtonTextChanged_WithValidText() {
        let updatedText = "Updated Button Text"
        
        vm.didAnswerButtonTextChanged(text: updatedText)
        
        XCTAssertEqual(mockRecord.buttonText, "Yes", "Record should not be updated until save is called")
        
        vm.saveChangesTapped()
        
        XCTAssertEqual(mockRecord.buttonText, updatedText, "Record should be updated with new button text")
    }
    
    func testDidAnswerButtonTextChanged_WithNilText() {
        vm.didAnswerButtonTextChanged(text: nil)

        XCTAssertEqual(mockRecord.buttonText, "Yes", "Button text should not change")
        
        vm.saveChangesTapped()
        
        XCTAssertEqual(mockRecord.buttonText, "Yes", "Button text should not change")
    }
} 
