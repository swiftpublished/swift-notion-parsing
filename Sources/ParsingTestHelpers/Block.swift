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
}
