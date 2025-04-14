import Foundation
@testable import Did_You_Today

class MockNotificationCenter: NotificationCenterProtocol {
    var addObserverCalled = false
    var removeObserverCalled = false
    var postCalled = false
    
    var lastObserver: Any?
    var lastSelector: Selector?
    var lastName: NSNotification.Name?
    var lastPostedName: NSNotification.Name?
    
    // Store registered observers
    private var observers: [(observer: Any, selector: Selector, name: NSNotification.Name?)] = []
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        addObserverCalled = true
        lastObserver = observer
        lastSelector = selector
        lastName = name
        
        // Store the observer to use when post is called
        observers.append((observer: observer, selector: selector, name: name))
    }
    
    func removeObserver(_ observer: Any) {
        removeObserverCalled = true
        lastObserver = observer
        
        // Remove all instances of this observer from the list
        // Use AnyObject identity comparison to ensure proper removal
        observers.removeAll { storedObserver in
            if let storedAnyObject = storedObserver.observer as AnyObject?,
               let observerAnyObject = observer as AnyObject? {
                return storedAnyObject === observerAnyObject
            }
            return false
        }
    }
    
    func post(name: NSNotification.Name, object: Any?) {
        postCalled = true
        lastPostedName = name
        
        // Find matching observers and call their selectors
        for (observer, selector, observerName) in observers {
            if observerName == name || observerName == nil {
                // Call the selector on the observer
                if let target = observer as? NSObject {
                    target.perform(selector)
                }
            }
        }
    }
    
    func reset() {
        addObserverCalled = false
        removeObserverCalled = false
        postCalled = false
        lastObserver = nil
        lastSelector = nil
        lastName = nil
        lastPostedName = nil
        observers.removeAll()
    }
} 