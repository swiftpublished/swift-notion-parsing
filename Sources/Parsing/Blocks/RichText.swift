import Foundation
import MacrosInterface

public struct RichText: Equatable, Codable {
    public let type: Types
    public let annotations: Annotations

    public init(type: Types, annotations: Annotations) {
        self.type = type
        self.annotations = annotations
    }
}

public extension RichText {
    enum Types: Codable, Equatable, CustomStringConvertible {
        case text(Text)

        public var description: String {
            switch self {
            case .text(let text):
                return text.content
            }
        }
    }

    @PublicInit
    struct Annotations: Codable, Equatable {
        public let bold: Bool
        public let italic: Bool
        public let strikethrough: Bool
        public let underline: Bool
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

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        var typesContainer = encoder.container(keyedBy: CodingKeys.Types.self)
        switch self.type {
        case .text(let text):
            try container.encode(CodingKeys.Types.text.rawValue, forKey: .type)
            try typesContainer.encode(text, forKey: .text)
        }

        try container.encodeIfPresent(annotations, forKey: .annotations)
    }
}

public extension RichText.Types {
    @PublicInit
    struct Text: Codable, Equatable {
        let content: String
        let link: Link?
    }
}

public extension RichText.Types.Text {
    @PublicInit
    struct Link: Codable, Equatable {
        let url: URL
    }
}
