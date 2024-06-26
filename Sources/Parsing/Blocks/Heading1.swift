import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys(using: .snake_case)
    struct Heading1: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]
        @CodingKey(name: "is_toggleable")
        public let isToggleable: Bool
    }
}
