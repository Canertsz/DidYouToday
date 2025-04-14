//
//  MockAddDidYouView.swift
//  Did You TodayTests
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import XCTest
@testable import Did_You_Today

class MockAddDidYouView: AddDidYouViewProtocol {
    var setupUICalled = false
    var setButtonBackgroundColorCalled = false
    var setupColorPickerViewCalled = false
    var enableNextPageNavigationCalled = false
    var disableNextPageNavigationCalled = false
    var observeTextfieldsCalled = false
    var lastReceivedHexColor: String?
    var lastReceivedDelegate: ColorPickerViewModelDelegate?
    
    func setupUI() {
        setupUICalled = true
    }
    
    func setButtonBackgroundColor(hex: String) {
        setButtonBackgroundColorCalled = true
        lastReceivedHexColor = hex
    }
    
    func setupColorPickerView(delegate: ColorPickerViewModelDelegate) {
        setupColorPickerViewCalled = true
        lastReceivedDelegate = delegate
    }
    
    func enableNextPageNavigation() {
        enableNextPageNavigationCalled = true
    }
    
    func disableNextPageNavigation() {
        disableNextPageNavigationCalled = true
    }
    
    func observeTextfields() {
        observeTextfieldsCalled = true
    }
} 