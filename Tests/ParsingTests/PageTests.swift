@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class PageTests: XCTestCase {
    func test_basic() throws {
        let json: String = """
        {
            "id": "59833787-2cf9-4fdf-8782-e53db20768a5",
            "last_edited_time": "2020-03-17T19:10:04.968Z",
            "properties": {
                "Name": {
                    "title": [
                        {
                            "type": "text",
                            "text": {
                                "content": "Title",
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
                    ]
                }
            }
        }
        """

        let expected: Page = .noContent(
            id: "59833787-2cf9-4fdf-8782-e53db20768a5",
            lastEditedTime: "2020-03-17T19:10:04.968Z",
            title: [.text("Title")]
        )

        try assert(decoding: json, to: expected)
    }
}
