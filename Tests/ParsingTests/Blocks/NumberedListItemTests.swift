@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class NumberedListItemTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "Number 1",
                        "link": null
                    },
                    "annotations": {
                        "bold": false,
                        "italic": false,
                        "strikethrough": false,
                        "underline": false,
                        "code": false,
                        "color": "default"
                    },
                    "plain_text": "Number 1",
                    "href": null
                }
            ]
        }
        """

        let expected = Block.NumberedListItem(richTexts: [.text("Number 1")], children: nil)

        try assert(decoding: json, to: expected)
    }
}
