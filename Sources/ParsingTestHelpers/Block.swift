import Foundation
import NotionParsing

extension Block {
    static func paragraph(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        paragraph: [RichText],
        paragraphChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let paragraph = Block.Paragraph(richTexts: paragraph, children: paragraphChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .paragraph(paragraph),
            level: level,
            children: blockChildren
        )
        return block
    }
    
    static func paragraph(_ paragraph: [RichText]) -> Self {
        .paragraph(id: UUID.zeros.uuidString, paragraph: paragraph)
    }
    
    static func heading1(id: String, heading1: [RichText]) -> Self {
        let heading1 = Block.Heading(richTexts: heading1, isToggleable: false)
        let block = Block(
            id: id,
            hasChildren: false,
            type: .heading1(heading1),
            level: nil,
            children: nil
        )
        return block
    }
    
    static func externalImage(url: String, caption: [RichText]?) -> Self {
        let image: Self.Image = .external(url: url, caption: caption)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .image(image),
            level: nil,
            children: nil
        )
        return block
    }
    
    static func notionImage(url: String, expiry: String) -> Self {
        let image: Self.Image = .notion(url: url, expiry: expiry)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .image(image),
            level: nil,
            children: nil
        )
        return block
    }
    
    static func quote(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        quote: [RichText],
        quoteChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let quote = Block.Quote(richTexts: quote, children: quoteChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .quote(quote),
            level: level,
            children: blockChildren
        )
        return block
    }
    
    static func quote(_ quote: [RichText]) -> Self {
        .quote(id: UUID.zeros.uuidString, quote: quote)
    }
    
    static func externalVideo(url: String, caption: [RichText]?) -> Self {
        let video: Self.Video = .external(url: url, caption: caption)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .video(video),
            level: nil,
            children: nil
        )
        return block
    }

    static func externalCallout(url: String, richTexts: [RichText]) -> Self {
        let callout: Self.Callout = .external(url: url, richTexts: richTexts)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .callout(callout),
            level: nil,
            children: nil
        )
        return block
    }

    static func notionCallout(url: String, expiry: String, richTexts: [RichText]) -> Self {
        let callout: Self.Callout = .notion(url: url, expiry: expiry, richTexts: richTexts)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .callout(callout),
            level: nil,
            children: nil
        )
        return block
    }

    static func emojiCallout(emoji: String, richTexts: [RichText]) -> Self {
        let callout: Self.Callout = .emoji(emoji: emoji, richTexts: richTexts)
        let block = Block(
            id: UUID.zeros.uuidString,
            hasChildren: false,
            type: .callout(callout),
            level: nil,
            children: nil
        )
        return block
    }

    static func numberedListItem(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        numberedListItem: [RichText],
        numberedListItemChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let numberedListItem = Block.NumberedListItem(richTexts: numberedListItem, children: numberedListItemChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .numberedListItem(numberedListItem),
            level: level,
            children: blockChildren
        )
        return block
    }
    
    static func tableRow(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        tableRow: [[RichText]],
        tableRowChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let tableRow = Block.TableRow(richTexts: tableRow, children: tableRowChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .tableRow(tableRow),
            level: level,
            children: blockChildren
        )
        return block
    }

    static func toggle(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        toggle: [RichText],
        toggleChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let toggle = Block.Toggle(richTexts: toggle, children: toggleChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .toggle(toggle),
            level: level,
            children: blockChildren
        )
        return block
    }

    static func todo(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        todo: [RichText],
        todoChecked: Bool = false,
        todoChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let todo = Block.Todo(richTexts: todo, checked: todoChecked, children: todoChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .todo(todo),
            level: level,
            children: blockChildren
        )
        return block
    }
}
