import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    struct Image: Codable, Equatable {
        public let file: File

        public init(from decoder: Decoder) throws {
            self.file = try File(from: decoder)
        }

        public func encode(to encoder: any Encoder) throws {
            try file.encode(to: encoder)
        }
    }
}

public extension Block {
    @PublicInit
    struct File: Codable, Equatable {
        public let caption: [RichText]?
        public let type: Types
        public let name: String?

        public var alternateText: String? {
            caption?.plainTexts
        }

        public enum Types: Codable, Equatable {
            case notion(NotionHosted)
            case external(External)

            public var url: URL {
                switch self {
                case .notion(let file):
                    file.url
                case .external(let file):
                    file.url
                }
            }
        }

        enum CodingKeys: CodingKey {
            case caption
            case name
            case type

            enum Types: String, CodingKey, Decodable {
                case file
                case external
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.caption = try container.decodeIfPresent([RichText].self, forKey: .caption)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)

            let type = try container.decode(CodingKeys.Types.self, forKey: .type)
            let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
            switch type {
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

            try container.encodeIfPresent(caption, forKey: .caption)
            try container.encodeIfPresent(name, forKey: .name)

            var typesContainer = encoder.container(keyedBy: CodingKeys.Types.self)
            switch self.type {
            case .notion(let file):
                try container.encode(CodingKeys.Types.file.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .file)
            case .external(let file):
                try container.encode(CodingKeys.Types.external.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .external)
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
