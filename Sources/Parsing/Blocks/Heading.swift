import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys(using: .snake_case)
    struct Heading: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        public let isToggleable: Bool
    }
}
