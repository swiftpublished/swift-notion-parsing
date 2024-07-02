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
        .paragraph(
            id: "00000000-0000-0000-0000-000000000000",
            paragraph: paragraph
        )
    }
}
