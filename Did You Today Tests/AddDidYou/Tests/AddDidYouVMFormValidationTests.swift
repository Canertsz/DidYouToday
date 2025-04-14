//
//  AddDidYouVMFormValidationTests.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

final class AddDidYouVMFormValidationTests: AddDidYouVMTestCase {
    
    // MARK: - Tests
    func testFormChangeEnablesNextButtonWhenBothFieldsAreSet() {
        vm.didActivityNameTextChanged(text: "Test Activity")
        vm.didAnswerButtonTextChanged(text: "Yes")

        XCTAssertTrue(mockView.enableNextPageNavigationCalled, "Enable navigation should be called when both fields are filled")
    }
    
    func testFormChangeDisablesNextButtonWhenActivityNameIsEmpty() {
        vm.didActivityNameTextChanged(text: "Test Activity")
        vm.didAnswerButtonTextChanged(text: "Yes")

        mockView.enableNextPageNavigationCalled = false
        mockView.disableNextPageNavigationCalled = false
        
        vm.didActivityNameTextChanged(text: "")

        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called when activity name is empty")
        XCTAssertTrue(mockView.disableNextPageNavigationCalled, "Disable navigation should be called when activity name is empty")
    }
    
    func testFormChangeDisablesNextButtonWhenAnswerButtonTextIsEmpty() {
        vm.didActivityNameTextChanged(text: "Test Activity")
        vm.didAnswerButtonTextChanged(text: "Yes")
        
        mockView.enableNextPageNavigationCalled = false
        mockView.disableNextPageNavigationCalled = false
        
        vm.didAnswerButtonTextChanged(text: "")
        
        XCTAssertFalse(mockView.enableNextPageNavigationCalled, "Enable navigation should not be called when answer button text is empty")
        XCTAssertTrue(mockView.disableNextPageNavigationCalled, "Disable navigation should be called when answer button text is empty")
    }
} 
