import XCTest
@testable import Did_You_Today

class MockHomeView: HomeViewProtocol {
    var setupUICalled = false
    var reloadUICalled = false
    
    func setupUI() {
        setupUICalled = true
    }
    
    func reloadUI() {
        reloadUICalled = true
    }
} 