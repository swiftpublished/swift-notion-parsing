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
        public let title: Text

        @CodingKey(name: "Description")
        public let description: Text

        @CodingKey(name: "Logo")
        public let logo: Block.URL

        @CodingKey(name: "Logo Alternate Text")
        public let logoAlternateText: Text

        @CodingKey(name: "CTA")
        public let cta: Text

        @CodingKey(name: "Website")
        public let website: Block.URL

        @CodingKey(name: "Status")
        public let status: Block.Checkbox

        @PublicInit
        @CodingKeys
        public struct Text: Codable, Equatable {
            @CodingKey(name: "rich_text")
            public let richTexts: [RichText]
        }
    }
}
