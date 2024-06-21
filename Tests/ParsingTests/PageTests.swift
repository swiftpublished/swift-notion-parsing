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

private extension Page {
    static func noContent(id: String, lastEditedTime: String, title richTexts: [RichText]) -> Self {
        let title = Page.Properties.Title(richTexts: richTexts)
        let properties = Page.Properties(title: title)

        return Page(
            id: UUID(uuidString: id)!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: lastEditedTime)!,
            properties: properties,
            content: nil
        )
    }

    static func paragraphContent(
        id: String, 
        lastEditedTime: String,
        title richTexts: [RichText],
        blockId: String,
        paragraph: [RichText]
    ) -> Self {
        let title = Page.Properties.Title(richTexts: richTexts)
        let properties = Page.Properties(title: title)

        let paragraph = Block.Paragraph(richTexts: paragraph, children: nil)
        let block = Block(id: blockId, hasChildren: false, type: .paragraph(paragraph), children: nil)
        let content = Content(nextCursor: nil, hasMore: false, blocks: [block])

        return Page(
            id: UUID(uuidString: id)!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: lastEditedTime)!,
            properties: properties,
            content: content
        )
    }
}
