import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    struct Image: Codable, Equatable {
        public let caption: [RichText]?
        public let type: Types

        public var alternateText: String? {
            caption?.map(\.plainText).joined()
        }

        enum CodingKeys: CodingKey {
            case caption
            case type

            enum Types: String, CodingKey, Decodable {
                case file
                case external
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.caption = try container.decodeIfPresent([RichText].self, forKey: .caption)

            let type = try container.decode(CodingKeys.Types.self, forKey: .type)
            let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
            switch type {
            case .file:
                let file = try typesContainer.decode(Types.NotionHostedFile.self, forKey: .file)
                self.type = .file(file)
            case .external:
                let file = try typesContainer.decode(Types.ExternalFile.self, forKey: .external)
                self.type = .external(file)
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encodeIfPresent(caption, forKey: .caption)

            var typesContainer = encoder.container(keyedBy: CodingKeys.Types.self)
            switch self.type {
            case .file(let file):
                try container.encode(CodingKeys.Types.file.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .file)
            case .external(let file):
                try container.encode(CodingKeys.Types.external.rawValue, forKey: .type)
                try typesContainer.encode(file, forKey: .external)
            }
        }

        public enum Types: Codable, Equatable {
            case file(NotionHostedFile)
            case external(ExternalFile)

            @PublicInit
            @CodingKeys(using: .snake_case)
            public struct NotionHostedFile: Codable, Equatable {
                let url: URL
                let expiryTime: Date
            }

            @PublicInit
            public struct ExternalFile: Codable, Equatable {
                public let url: URL
            }
        }
    }
}
