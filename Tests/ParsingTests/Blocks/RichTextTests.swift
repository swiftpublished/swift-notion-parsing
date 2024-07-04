@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class RichTextTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "Paragraph",
                "link": null
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false
            },
            "plain_text": "Paragraph"
        }
        """

        let expected: RichText = .text("Paragraph")

        try assert(decoding: json, to: expected)
    }

    func test_text_with_link() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "Paragraph",
                "link": {
                    "url": "https://developers.notion.com"
                }
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false
            },
            "plain_text": "Paragraph"
        }
        """

        let expected: RichText = .text("Paragraph", link: "https://developers.notion.com")

        try assert(decoding: json, to: expected)
    }
}
