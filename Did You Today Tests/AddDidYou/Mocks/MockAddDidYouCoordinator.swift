//
//  MockAddDidYouCoordinator.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

class MockAddDidYouCoordinator: AddDidYouCoordinatorProtocol {
    var navigateToNotificationPreferenceScreenCalled = false
    var lastReceivedButtonColor: String?
    var lastReceivedAnswerButtonText: String?
    var lastReceivedActivityName: String?
    
    func navigateToNotificationPreferenceScreen(buttonColor: String, answerButtonText: String, activityName: String) {
        navigateToNotificationPreferenceScreenCalled = true
        lastReceivedButtonColor = buttonColor
        lastReceivedAnswerButtonText = answerButtonText
        lastReceivedActivityName = activityName
    }
} 