import XCTest
@testable import UnitTestExample

class MockAppAppearance: AppApearance {
    
    var overridenColor: UIColor!
    
    override func defaultBackgroundColor() -> UIColor {
        return overridenColor
    }
}

class ViewControllerTests: XCTestCase {
    
    var sut: ViewController!
    var mockAppearance: MockAppAppearance!
    
    override func setUp() {
        sut = ViewController()
        mockAppearance = MockAppAppearance()
        sut.appearance = mockAppearance
    }
    
    override func tearDown() {
        sut = nil
        mockAppearance = nil
    }
    
    func testBackgroundColorShouldBeSameAsDefault() {

        // Precondition
        mockAppearance.overridenColor = UIColor.whiteColor();
        
        // perform
        sut.viewDidLoad()

        // Expect
        XCTAssertEqual(sut.view.backgroundColor, mockAppearance.overridenColor, "View collor should be same as appearance color")

    }
    
    func testBackgroundColorShouldBeSameAsDefaultBlack() {
        
        // Preconditions
        mockAppearance.overridenColor = UIColor.blackColor();
        
        // perform
        sut.viewDidLoad()
        
        // Expect
        XCTAssertEqual(sut.view.backgroundColor, mockAppearance.overridenColor, "View collor should be same as appearance color")
        
    }
    
}
