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

        @PublicInit
        @CodingKeys
        public struct Title: Codable, Equatable {
            @CodingKey(name: "title")
            public let richTexts: [RichText]

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                self.richTexts = try container.decode([RichText].self, forKey: .richTexts)
            }
        }
    }
}
