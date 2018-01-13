import XCTest
@testable import SwiftStreams

class HelloTests: XCTestCase {
    
    func test_say_hello_to_sandro() {
        // given
        let buddy = "Sandro"
        
        // when
        let str = Hello().sayHi(buddy: buddy)
        
        // then
        XCTAssertEqual(str, "Hi Sandro")
    }
}
