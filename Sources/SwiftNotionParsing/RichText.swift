import Foundation

struct RichText: Decodable, Equatable {
    let kind: Kind
    let annotations: Annotations

    enum CodingKey: Swift.CodingKey {
        case type
        case text
        case annotations
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKey.self)

        let kind = try container.decode(Kind.RawValue.self, forKey: .type)
        switch kind {
        case .text:
            let text = try container.decode(Kind.Text.self, forKey: .text)
            self.kind = .text(text)
        }

        self.annotations = try container.decode(Annotations.self, forKey: .annotations)
    }
}

extension RichText {
    enum Kind: Decodable, Equatable, CustomStringConvertible {
        case text(Text)

        enum RawValue: String, Decodable {
            case text
        }

        var description: String {
            switch self {
            case .text(let text):
                text.content
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

    init(type: Kind, annotations: Annotations) {
        self.kind = type
        self.annotations = annotations
    }
}

extension RichText.Kind {
    struct Text: Decodable, Equatable {
        let content: String
        let link: Link?
    }
}

extension RichText.Kind.Text {
    struct Link: Decodable, Equatable {
        let url: URL
    }
}
