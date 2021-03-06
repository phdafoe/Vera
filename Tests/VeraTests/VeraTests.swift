import XCTest
@testable import Vera

final class VeraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Vera().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
