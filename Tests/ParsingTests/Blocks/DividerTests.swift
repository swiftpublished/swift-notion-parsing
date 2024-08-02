@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class DividerTests: XCTestCase {
    func test_basic() throws {
        let json = """
                {
                    "type": "divider",
                    "divider": {}
                }
                """
        let expected = Block.Divider()
        try assert(decoding: json, to: expected)
    }
}
