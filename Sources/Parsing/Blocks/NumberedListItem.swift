import MacrosInterface

public extension Block {
    @CodingKeys(using: .snake_case)
    struct NumberedListItem: Codable, Equatable {
        @CodingKey(name: "rich_text")
        let richTexts: [RichText]

        let children: [Block]?
    }
}
