import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys(using: .snake_case)
    struct Todo: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        let checked: Bool?
        let children: [Block]?
    }
}
