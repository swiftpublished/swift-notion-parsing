import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Code: Codable, Equatable {
        public let caption: [RichText]

        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        public let language: Language

        public enum Language: String, Codable {
            case swift
        }
    }
}

public extension Block.Code {
    var plainText: String {
        richTexts.map(\.plainText).joined()
    }
}
