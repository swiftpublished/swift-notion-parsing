import Foundation
import NotionParsing

extension Page {
    static func noContent(
        id: String = UUID.zeros.uuidString,
        lastEditedTime: String = "2024-01-01T00:00:00.000Z",
        title richTexts: [RichText]
    ) -> Self {
        let title = Page.Properties.Title(richTexts: richTexts)
        let properties = Page.Properties(
            title: title,
            status: nil,
            author: nil,
            articleTitle: nil,
            articleDescription: nil,
            coverDescription: nil,
            metaTitle: nil,
            metaDescription: nil,
            tags: nil
        )

        return Page(
            id: UUID(uuidString: id)!,
            createdTime: DateFormatter.iso8601Notion.date(from: "2000-00-00T00:00:00.000Z")!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: lastEditedTime)!,
            cover: nil,
            properties: properties,
            content: nil
        )
    }

    static func paragraphContent(
        id: String = UUID.zeros.uuidString,
        lastEditedTime: String = "2024-01-01T00:00:00.000Z",
        title richTexts: [RichText],
        blockId: String = UUID.ones.uuidString,
        paragraph: [RichText]
    ) -> Self {
        let title = Page.Properties.Title(richTexts: richTexts)
        let properties = Page.Properties(
            title: title,
            status: nil,
            author: nil,
            articleTitle: nil,
            articleDescription: nil,
            coverDescription: nil,
            metaTitle: nil,
            metaDescription: nil,
            tags: nil
        )

        let block: Block = .paragraph(id: blockId, paragraph: paragraph)
        let content = Content(nextCursor: nil, hasMore: false, blocks: [block])

        return Page(
            id: UUID(uuidString: id)!,
            createdTime: DateFormatter.iso8601Notion.date(from: "2000-00-00T00:00:00.000Z")!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: lastEditedTime)!,
            cover: nil,
            properties: properties,
            content: content
        )
    }
}
