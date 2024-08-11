import Foundation
import MacrosInterface

@PublicInit
@CodingKeys(using: .snake_case)
public struct Page: Codable, Equatable {
    let id: UUID
    let lastEditedTime: Date
    public let properties: Properties
    public var content: Content?

    @PublicInit
    @CodingKeys
    public struct Properties: Codable, Equatable {
        public let title: Title

        @CodingKey(name: "Rich Title")
        public let richTitle: RichTitle?
        @PublicInit
        @CodingKeys
        public struct Title: Codable, Equatable {
            @CodingKey(name: "title")
            public let richTexts: [RichText]
        }
        @PublicInit
        @CodingKeys
        public struct RichTitle: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }
    }
}
