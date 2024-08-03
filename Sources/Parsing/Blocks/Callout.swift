import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Callout: Codable, Equatable {
        @CodingKey(name: "rich_text")
        let richTexts: [RichText]

        public let icon: Icon
        
        public init(from decoder: any Decoder) throws {
            self.richTexts = try [RichText](from: decoder)
            self.icon = try Icon(from: decoder)
        }

        public func encode(to encoder: any Encoder) throws {
            try richTexts.encode(to: encoder)
            try icon.encode(to: encoder)
        }
    }
}

public extension Block {
    @PublicInit
    struct Icon: Codable, Equatable {
        public let type: Types

        public enum Types: Codable, Equatable {
            case emoji(String)
            case external(External)
            case notion(NotionHosted)
            public var url: URL? {
                switch self {
                case .notion(let file):
                    file.url
                case .external(let file):
                    file.url
                case .emoji(_):
                    nil
                }
            }
        }

        enum CodingKeys: CodingKey {
            case type

            enum Types: String, CodingKey, Decodable {
                case emoji
                case file
                case external
            }
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let type = try container.decode(CodingKeys.Types.self, forKey: .type)
            let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
            switch type {
            case .emoji:
                let emoji = try typesContainer.decode(String.self, forKey: .emoji)
                self.type = .emoji(emoji)
            case .file:
                let file = try typesContainer.decode(NotionHosted.self, forKey: .file)
                self.type = .notion(file)
            case .external:
                let file = try typesContainer.decode(External.self, forKey: .external)
                self.type = .external(file)
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            var typesContainer = encoder.container(keyedBy: CodingKeys.Types.self)
            switch self.type {
            case .notion(let file):
                try container.encode(CodingKeys.Types.file.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .file)
            case .external(let file):
                try container.encode(CodingKeys.Types.external.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .external)
            case .emoji(let value):
                try container.encode(CodingKeys.Types.emoji.rawValue, forKey: .type)
                try typesContainer.encode(value, forKey: .external)
            }
        }

        @PublicInit
        @CodingKeys(using: .snake_case)
        public struct NotionHosted: Codable, Equatable {
            let url: URL
            let expiryTime: Date
        }

        @PublicInit
        public struct External: Codable, Equatable {
            public let url: URL
        }
    }
}
