import XCTest
@testable import Dice

final class DiceTests: XCTestCase {
    
    func testRoll1d6() {
        // Since we have a random value each test will be dealing with a different answer.
        let result = roll(1, d:6)
        XCTAssert(result > 0)
        XCTAssert(result < 7)
    }
    
    func testRoll3d10() {
        // Since we have a random value each test will be dealing with a different answer.
        let result = roll(3, d:10)
        XCTAssert(result > 2)
        XCTAssert(result < 31)
    }
    
    func testRollRange() {
        do {
            let result = try rollRange("1-4")
            XCTAssert(result > 0)
            XCTAssert(result < 5)
        } catch {
            XCTFail()
        }

    }
    
    func testRollRangeReverse() {
        do {
            let result = try rollRange("4-1")
            XCTAssert(result > 0)
            XCTAssert(result < 5)
        } catch {
            XCTFail()
        }

    }
    
    func testRollRangeZero() {
        do {
            let result = try rollRange("0-3")
            XCTAssert(result > -1)
            XCTAssert(result < 4)
        } catch {
            XCTFail()
        }
    }
    
    func testRollRangeBadInput() {
        XCTAssertThrowsError(try rollRange("1x4")) { error in
            XCTAssertEqual(error as! DiceError, DiceError.InvalidInput)
        }
    }
    
    static var allTests = [
        ("testRoll1d6", testRoll1d6),
        ("testRoll3d10", testRoll3d10),
        ("testRollRange", testRollRange),
        ("testRollRangeZero", testRollRangeZero),
    ]
}
