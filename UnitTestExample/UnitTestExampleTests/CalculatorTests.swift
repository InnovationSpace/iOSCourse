import XCTest
@testable import UnitTestExample

class CalculatorTests: XCTestCase {
    
    var sut: Calculator!
    
    override func setUp() {
        sut = Calculator()
    }
    
    
    func testClassAddMethodsShouldAddNumbers() {
        let result = Calculator.add(7, b: 8)
        XCTAssertEqual(result, 15, "7 + 8 should be equall to 15")
    }
    
    func testClassAddMethodsAdd7and10ShouldBeEqual17() {
        let result = Calculator.add(7, b: 10)
        XCTAssertEqual(result, 17, "7 + 8 should be equall to 15")
    }
    
    func testCalculatorShouldHave0AsInitialState() {
        XCTAssertEqual(sut.result, 0, "Initial state 0")
    }
    
    func testCalculatorShouldIncreaseStateBy5() {
        sut.add(5)
        XCTAssertEqual(sut.result, 5, "Adding 5 to calculator should change result to 5")
    }
    
    func testFromStartingState5Add5ShouldChangeResultTo10() {
        sut.result = 5
        sut.add(5)
        XCTAssertEqual(sut.result, 10, "When starting state is equal to 5, adding 5 to calculator should change result to 10")
    }
}
