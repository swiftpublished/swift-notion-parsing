import Foundation
import MacrosInterface

@PublicInit
public struct SponsorPage: Codable, Equatable {
    public let id: UUID
    public let properties: Properties

    @PublicInit
    @CodingKeys
    public struct Properties: Codable, Equatable {
        @CodingKey(name: "Title")
        public let title: Title

        @CodingKey(name: "Description")
        public let description: Text

        @CodingKey(name: "Image")
        public let image: Block.URL

        @CodingKey(name: "Image Alternate Text")
        public let imageAlternateText: Text

        @CodingKey(name: "CTA")
        public let cta: Text

        @CodingKey(name: "Website")
        public let website: Block.URL

        @CodingKey(name: "Status")
        public let status: Block.Checkbox

        @PublicInit
        @CodingKeys
        public struct Title: Codable, Equatable {
            @CodingKey(name: "title")
            public let richTexts: [RichText]
        }

        @PublicInit
        @CodingKeys
        public struct Text: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }
    }
}
