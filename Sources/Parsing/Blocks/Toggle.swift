import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Toggle: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        let children: [Block]?
    }
}
