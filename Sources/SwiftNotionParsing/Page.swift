import Foundation
import SwiftMacrosInterface

@CodingKeys(using: .snake_case)
struct Page: Decodable, Equatable {
    let id: UUID
    let lastEditedTime: Date
    let properties: Properties

    @CodingKeys
    struct Properties: Decodable, Equatable {
        @CodingKey(name: "Name")
        let title: Title

        struct Title: Decodable, Equatable {
            let text: String

            enum CodingKey: Swift.CodingKey {
                case title
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKey.self)

                let texts = try container.decode([RichText].self, forKey: .title)
                self.text = texts.map(\.kind.description).joined()
            }

            init(text: String) {
                self.text = text
            }
        }
    }
}
