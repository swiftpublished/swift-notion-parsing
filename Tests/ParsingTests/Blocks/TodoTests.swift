@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class TodoTests: XCTestCase {
    func test_basic_text() throws {
        let json = """
                {
                    "rich_text": [
                        {
                            "type": "text",
                            "text": {
                                "content": "notion-parsing",
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
                            "plain_text": "notion-parsing",
                            "href": null
                        }
                    ],
                    "checked": false,
                    "color": "default"
                }
                """
        let expected: Block.Todo = Block.Todo(richTexts: [.text("notion-parsing")], checked: false, children: nil)
        try assert(decoding: json, to: expected)
    }
}
