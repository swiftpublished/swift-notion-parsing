@testable import NotionParsing
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
                                "content": "A better title for the page",
                                "link": null
                            },
                            "annotations": {
                                "bold": false,
                                "italic": false,
                                "strikethrough": false,
                                "underline": false,
                                "code": false,
                                "color": "default"
                            }
                        }
                    ]
                }
            }
        }
        """

        let title = Page.Properties.Title(text: "A better title for the page")
        let properties = Page.Properties(title: title)
        let expected = Page(
            id: UUID(uuidString: "59833787-2cf9-4fdf-8782-e53db20768a5")!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: "2020-03-17T19:10:04.968Z")!,
            properties: properties
        )

        try assert(decoding: json, to: expected)
    }
}
