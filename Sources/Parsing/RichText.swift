import Foundation

struct RichText: Equatable {
    let type: Types
    let annotations: Annotations
}

extension RichText: Decodable {
    enum Types: Decodable, Equatable, CustomStringConvertible {
        case text(Text)

        var description: String {
            switch self {
            case .text(let text):
                return text.content
            }
        }
    }

    struct Annotations: Decodable, Equatable {
        let bold: Bool
        let italic: Bool
        let strikethrough: Bool
        let underline: Bool
        let code: Bool
    }
}

extension RichText {
    enum CodingKeys: CodingKey {
        case type
        case annotations

        enum Types: String, CodingKey, Decodable {
            case text
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let type = try container.decode(CodingKeys.Types.self, forKey: .type)
        let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
        switch type {
        case .text:
            let text = try typesContainer.decode(Types.Text.self, forKey: .text)
            self.type = .text(text)
        }

        self.annotations = try container.decode(Annotations.self, forKey: .annotations)
    }
}

extension RichText.Types {
    struct Text: Decodable, Equatable {
        let content: String
        let link: Link?
    }
}

extension RichText.Types.Text {
    struct Link: Decodable, Equatable {
        let url: URL
    }
}
