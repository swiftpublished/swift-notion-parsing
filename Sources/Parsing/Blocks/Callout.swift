import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Callout: Codable, Equatable {
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]

        public let icon: Icon
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.richTexts = try container.decode([RichText].self, forKey: .richTexts)
            self.icon = try container.decode(Icon.self, forKey: .icon)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(richTexts, forKey: .richTexts)
            try container.encode(icon, forKey: .icon)
        }
    }
}

public extension Block {
    @PublicInit
    struct Icon: Codable, Equatable {
        public let type: IconType

        public enum IconType: Codable, Equatable {
            case emoji(String)
            case external(External)
            case file(NotionHosted)
        }

        enum CodingKeys: String, CodingKey {
            case type
            case emoji
            case external
            case file
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "emoji":
                let emoji = try container.decode(String.self, forKey: .emoji)
                self.type = .emoji(emoji)
            case "file":
                let file = try container.decode(NotionHosted.self, forKey: .file)
                self.type = .file(file)
            case "external":
                let file = try container.decode(External.self, forKey: .external)
                self.type = .external(file)
            default:
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown icon type")
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self.type {
            case .emoji(let emoji):
                try container.encode("emoji", forKey: .type)
                try container.encode(emoji, forKey: .emoji)
            case .external(let external):
                try container.encode("external", forKey: .type)
                try container.encode(external, forKey: .external)
            case .file(let file):
                try container.encode("file", forKey: .type)
                try container.encode(file, forKey: .file)
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
