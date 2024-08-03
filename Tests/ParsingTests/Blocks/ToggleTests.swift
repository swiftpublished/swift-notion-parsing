@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class ToggleTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
                {
                    "rich_text": [
                        {
                            "type": "text",
                            "text": {
                                "content": "iOS Development",
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
                            "plain_text": "iOS Development",
                            "href": null
                        }
                    ],
                    "color": "default"
                }
        """
        let expected = Block.Toggle(richTexts: [.text("iOS Development")], children: nil)
        try assert(decoding: json, to: expected)
    }
}
