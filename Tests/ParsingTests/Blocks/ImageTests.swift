@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class ImageTests: XCTestCase {
    func test_basic_notion_file_decoding() throws {
        let json: String = """
        {
            "type": "file",
            "file": {
                "url": "https://host.com/image.png",
                "expiry_time": "2024-07-04T05:37:43.648Z"
            }
        }
        """

        let expected: Block.Image = .notion(
            url: "https://host.com/image.png",
            expiry: "2024-07-04T05:37:43.648Z"
        )

        try assert(decoding: json, to: expected)
    }

    func test_basic_external_file_decoding() throws {
        let json: String = """
        {
            "type": "external",
            "external": {
                "url": "https://host.com/image.png"
            }
        }
        """

        let expected: Block.Image = .external(url: "https://host.com/image.png", caption: nil)

        try assert(decoding: json, to: expected)
    }

    func test_basic_notion_file_encoding() throws {
        let image: Block.Image = .notion(
            url: "https://host.com/image.png",
            expiry: "2024-07-04T05:37:43.648Z"
        )

        let expected: String = """
        {
            "type": "file",
            "file": {
                "url": "https://host.com/image.png",
                "expiry_time": "2024-07-04T05:37:43.648Z"
            }
        }
        """

        try assert(encoding: image, to: expected)
    }

    func test_basic_external_file_encoding() throws {
        let image: Block.Image = .external(url: "https://host.com/image.png", caption: nil)

        let expected: String = """
        {
            "type": "external",
            "external": {
                "url": "https://host.com/image.png"
            }
        }
        """

        try assert(encoding: image, to: expected)
    }
}
