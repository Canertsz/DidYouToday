import XCTest
import CoreData
@testable import Did_You_Today

class HomeDidYouMock: DidYou {
    private var mockedActivityName: String?
    private var mockedButtonText: String?
    private var mockedButtonColor: String?
    private var mockedTimeLogs: [Date]?
    
    override var activityName: String? {
        get { return mockedActivityName }
        set { mockedActivityName = newValue }
    }
    
    override var buttonText: String? {
        get { return mockedButtonText }
        set { mockedButtonText = newValue }
    }
    
    override var buttonColor: String? {
        get { return mockedButtonColor }
        set { mockedButtonColor = newValue }
    }
    
    override var timeLogs: NSObject? {
        get { return mockedTimeLogs as NSObject? }
        set { mockedTimeLogs = newValue as? [Date] }
    }
    
    convenience init(activityName: String?, buttonText: String?, buttonColor: String?, timeLogs: [Date]? = nil) {
        self.init()
        self.mockedActivityName = activityName
        self.mockedButtonText = buttonText
        self.mockedButtonColor = buttonColor
        self.mockedTimeLogs = timeLogs
    }
} 