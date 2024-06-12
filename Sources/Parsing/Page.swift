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
        @CodingKey(name: "Name")
        public let title: Title

        @PublicInit
        @CodingKeys
        public struct Title: Codable, Equatable {
            @CodingKey(name: "title")
            public let text: String

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                let texts = try container.decode([RichText].self, forKey: .text)
                self.text = texts.map(\.type.description).joined()
            }
        }
    }
}
