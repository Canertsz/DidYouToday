//
//  AddDidYouVMTestCase.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

class AddDidYouVMTestCase: XCTestCase {
    
    var vm: AddDidYouVM!
    var mockView: MockAddDidYouView!
    var mockCoordinator: MockAddDidYouCoordinator!
    
    override func setUp() {
        super.setUp()
        mockView = MockAddDidYouView()
        mockCoordinator = MockAddDidYouCoordinator()
        vm = AddDidYouVM(view: mockView, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        vm = nil
        mockView = nil
        mockCoordinator = nil
        super.tearDown()
    }
} 
