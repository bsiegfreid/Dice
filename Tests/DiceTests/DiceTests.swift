import XCTest
@testable import Dice

final class DiceTests: XCTestCase {
    
    func test1d6() {
        // Since we have a random value each test will be dealing with a different answer.
        let result = roll(1, d:6)
        XCTAssert(result > 0)
        XCTAssert(result < 7)
    }
    
    func test3d10() {
        // Since we have a random value each test will be dealing with a different answer.
        let result = roll(3, d:10)
        XCTAssert(result > 2)
        XCTAssert(result < 31)
    }

    static var allTests = [
        ("test1d6", test1d6),
        ("test3d10", test3d10),
    ]
}
