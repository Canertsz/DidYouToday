//
//  AddDidYouVMNavigationTests.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

final class AddDidYouVMNavigationTests: AddDidYouVMTestCase {
    
    // MARK: - Tests
    func testNextPageButtonTapped() {
        let color = "#FF0000"
        vm.didSelectColor(hex: color)
        vm.didActivityNameTextChanged(text: "Test Activity")
        vm.didAnswerButtonTextChanged(text: "Yes")
        
        vm.nextPageButtonTapped()
        
        XCTAssertTrue(mockCoordinator.navigateToNotificationPreferenceScreenCalled, "navigateToNotificationPreferenceScreen should be called")
        XCTAssertEqual(mockCoordinator.lastReceivedButtonColor, color, "color should be passed")
        XCTAssertEqual(mockCoordinator.lastReceivedAnswerButtonText, "Yes", "Answer button text should match what was set")
        XCTAssertEqual(mockCoordinator.lastReceivedActivityName, "Test Activity", "Activity name should match what was set")
    }
} 
