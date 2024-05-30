import Foundation
import MacrosInterface

@CodingKeys(using: .snake_case)
public struct Page: Decodable, Equatable {
    let id: UUID
    let lastEditedTime: Date
    let properties: Properties

    @CodingKeys
    struct Properties: Decodable, Equatable {
        @CodingKey(name: "Name")
        let title: Title

        struct Title: Decodable, Equatable {
            let text: String

            enum CodingKeys: CodingKey {
                case title
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                let texts = try container.decode([RichText].self, forKey: .title)
                self.text = texts.map(\.type.description).joined()
            }

            init(text: String) {
                self.text = text
            }
        }
    }
}
