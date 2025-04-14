import XCTest
@testable import Did_You_Today

final class EditActivityVMColorPickerTests: EditActivityVMTestCase {
    
    func testDidSelectColor() {
        let color = "#00FF00"
        
        vm.didSelectColor(hex: color)
        
        XCTAssertTrue(mockView.setButtonBackgroundColorCalled, "setButtonBackgroundColor should be called")
        XCTAssertEqual(mockView.lastReceivedHexColor, color, "The received hex color should match what was passed")
        
        // Record shouldn't be updated immediately
        XCTAssertEqual(mockRecord.buttonColor, "#FF0000", "Record should not be updated until save is called")
        
        // When save is called
        vm.saveChangesTapped()
        
        XCTAssertEqual(mockRecord.buttonColor, color, "Record should be updated with new color")
    }
} 
