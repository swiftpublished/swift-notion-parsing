import Foundation
import NotionParsing

extension Page {
    static func noContent(
        id: String = "00000000-0000-0000-0000-000000000000",
        lastEditedTime: String = "2024-01-01T00:00:00.000Z",
        title richTexts: [RichText]
    ) -> Self {
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

        let block: Block = .paragraph(id: blockId, paragraph: paragraph)
        let content = Content(nextCursor: nil, hasMore: false, blocks: [block])

        return Page(
            id: UUID(uuidString: id)!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: lastEditedTime)!,
            properties: properties,
            content: content
        )
    }
}
