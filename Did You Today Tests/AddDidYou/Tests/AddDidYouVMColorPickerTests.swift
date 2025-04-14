//
//  AddDidYouVMColorPickerTests.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

final class AddDidYouVMColorPickerTests: AddDidYouVMTestCase {
    
    // MARK: - Tests
    func testDidSelectColor() {
        let testHexColor = "#FF0000"

        vm.didSelectColor(hex: testHexColor)

        XCTAssertTrue(mockView.setButtonBackgroundColorCalled, "setButtonBackgroundColor should be called")
        XCTAssertEqual(mockView.lastReceivedHexColor, testHexColor, "The received hex color should match what was passed")
    }
    
    func testDidSelectColorUpdatesButtonColorProperty() {
        let testHexColor = "#FF0000"
        
        vm.didSelectColor(hex: testHexColor)

        // We need to trigger nextPageButtonTapped to verify the color was stored
        vm.didActivityNameTextChanged(text: "Test Activity")
        vm.didAnswerButtonTextChanged(text: "Yes")
        vm.nextPageButtonTapped()
        
        XCTAssertEqual(mockCoordinator.lastReceivedButtonColor, testHexColor, "The stored button color should match what was selected")
    }
} 
