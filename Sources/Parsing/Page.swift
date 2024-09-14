import Foundation
import MacrosInterface

@PublicInit
@CodingKeys(using: .snake_case)
public struct Page: Codable, Equatable {
    public let id: UUID
    public let lastEditedTime: Date
    public let cover: Block.File?
    public let properties: Properties
    public var content: Content?

    @PublicInit
    @CodingKeys
    public struct Properties: Codable, Equatable {
        public let title: Title

        @CodingKey(name: "Article Title")
        public let articleTitle: RichTitle?

        @CodingKey(name: "Article Description")
        public let articleDescription: RichDescription?

        @CodingKey(name: "Cover Description")
        public let coverDescription: CoverDescription?

        @CodingKey(name: "Meta Title")
        public let metaTitle: MetaTitle?

        @CodingKey(name: "Meta Description")
        public let metaDescription: MetaDescription?

        @CodingKey(name: "Status")
        public let status: Status?

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
        public struct RichDescription: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }

        @PublicInit
        @CodingKeys
        public struct CoverDescription: Codable, Equatable {
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

        @PublicInit
        @CodingKeys
        public struct Status: Codable, Equatable {
            @CodingKey(name: "status")
            public let value: Value?

            public enum Value: String, Codable, Equatable {
                case to_do = "To-Do"
                case in_progress = "In-Progress"
                case in_review = "In-Review"
                case ready_to_release = "Ready To Release"
                case done = "Done"
                case unknown

                enum CodingKeys: CodingKey {
                    case name
                }

                public init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)

                    let name = try container.decode(String.self, forKey: .name)
                    self = Self(rawValue: name) ?? .unknown
                }

                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)

                    try container.encode(self.rawValue, forKey: .name)
                }
            }
        }
    }
}
