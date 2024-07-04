@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class ImageTests: XCTestCase {
    func test_basic_notion_file() throws {
        let json: String = """
        {
            "type": "file",
            "file": {
                "url": "https://host.com/image.png",
                "expiry_time": "2024-07-04T05:37:43.648Z"
            }
        }
        """

        let expected: Block.Image = .notionFile(
            url: "https://host.com/image.png", 
            expiry: "2024-07-04T05:37:43.648Z"
        )

        try assert(decoding: json, to: expected)
    }

    func test_basic_external_file() throws {
        let json: String = """
        {
            "type": "external",
            "external": {
                "url": "https://host.com/image.png"
            }
        }
        """

        let expected: Block.Image = .externalFile(url: "https://host.com/image.png")

        try assert(decoding: json, to: expected)
    }
}
