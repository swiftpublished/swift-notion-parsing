@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class Heading1Tests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "Heading 1",
                        "link": null
                    },
                    "annotations": {
                        "bold": false,
                        "italic": false,
                        "strikethrough": false,
                        "underline": false,
                        "code": false
                    }
                }
            ],
            "is_toggleable": false
        }
        """

        let expected = Block.Heading1(richTexts: [.text("Heading 1")], isToggleable: false)
        try assert(decoding: json, to: expected)
    }
}
