@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class HeadingTests: XCTestCase {
    func test_basic() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "Heading",
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

        let expected = Block.Heading(richTexts: [.text("Heading")], isToggleable: false)
        try assert(decoding: json, to: expected)
    }
}
