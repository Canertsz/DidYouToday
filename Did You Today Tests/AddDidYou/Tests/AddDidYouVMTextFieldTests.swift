//
//  AddDidYouVMTextFieldTests.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

final class AddDidYouVMTextFieldTests: AddDidYouVMTestCase {
    
    // MARK: - Activity Button Text Tests
    func testDidActivityNameTextChanged_WithValidText() {
        let testText = "Test Activity"
        
        vm.didActivityNameTextChanged(text: testText)

        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called yet since both fields need to be filled")
        XCTAssertTrue(mockView.disableNextPageNavigationCalled, "Disable navigation should be called")
        
        vm.didAnswerButtonTextChanged(text: "Button Text")
        XCTAssertTrue(mockView.enableNextPageNavigationCalled, "Enable navigation should be called once both fields are filled")
    }
    
    func testDidActivityNameTextChanged_WithNilText() {
        vm.didActivityNameTextChanged(text: nil)
        
        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called")
        XCTAssertFalse(mockView.disableNextPageNavigationCalled, "Disable navigation should not be called, as the method returns early for nil text")
    }
    
    // MARK: - Answer Button Text Tests
    func testDidAnswerButtonTextChanged_WithValidText() {
        let testText = "Yes"
        
        vm.didAnswerButtonTextChanged(text: testText)
        
        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called yet since both fields need to be filled")
        XCTAssertTrue(mockView.disableNextPageNavigationCalled, "Disable navigation should be called")
        
        // Now fill in the activity name too and verify navigation is enabled
        vm.didActivityNameTextChanged(text: "Activity Name")
        XCTAssertTrue(mockView.enableNextPageNavigationCalled, "Enable navigation should be called once both fields are filled")
    }
    
    func testDidAnswerButtonTextChanged_WithNilText() {
        vm.didAnswerButtonTextChanged(text: nil)
        
        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called")
        XCTAssertFalse(mockView.disableNextPageNavigationCalled, "Disable navigation should not be called, as the method returns early for nil text")
    }
} 
