import Foundation
import MacrosInterface

@PublicInit
@CodingKeys(using: .snake_case)
public struct Page: Codable, Equatable {
    let id: UUID
    let lastEditedTime: Date
    public let cover: Block.File?
    public let properties: Properties
    public var content: Content?

    @PublicInit
    @CodingKeys
    public struct Properties: Codable, Equatable {
        public let title: Title

        @CodingKey(name: "Rich Title")
        public let richTitle: RichTitle?

        @CodingKey(name: "Meta Title")
        public let metaTitle: MetaTitle?

        @CodingKey(name: "Meta Description")
        public let metaDescription: MetaDescription?

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

        @PublicInit
        @CodingKeys
        public struct MetaTitle: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }

        @PublicInit
        @CodingKeys
        public struct MetaDescription: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }
    }
}
