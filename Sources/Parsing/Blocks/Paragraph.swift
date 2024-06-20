import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Paragraph: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        let children: [Block]?
    }
}
