import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Quote: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        let children: [Block]?
    }
}
