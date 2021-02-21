import XCTest
@testable import ServiceStack

final class ServiceStackTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ServiceStack().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
