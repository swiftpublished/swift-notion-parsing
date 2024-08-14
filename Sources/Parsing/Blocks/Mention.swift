import MacrosInterface

public extension RichText.Types {
    @PublicInit
    struct Mention: Codable, Equatable {
        public let type: MentionType

        public enum MentionType: Codable, Equatable {
            case page(PageMention)
            case user(User)
            case date(DateMention)
        }

        enum CodingKeys: String, CodingKey {
            case type
            case page
            case user
            case date
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)

            switch type {
            case "page":
                let page = try container.decode(PageMention.self, forKey: .page)
                self.type = .page(page)
            case "user":
                let user = try container.decode(User.self, forKey: .user)
                self.type = .user(user)
            case "date":
                let date = try container.decode(DateMention.self, forKey: .date)
                self.type = .date(date)
            default:
                throw DecodingError.dataCorruptedError(forKey: CodingKeys.page, in: container, debugDescription: "Invalid type")

            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self.type {
            case .page(let page):
                try container.encode("page", forKey: .type)
                try container.encode(page, forKey: .page)
            case .user(let user):
                try container.encode("user", forKey: .type)
                try container.encode(user, forKey: .user)
            case .date(let date):
                try container.encode("date", forKey: .type)
                try container.encode(date, forKey: .date)
            }
        }

        @PublicInit
        public struct User: Codable, Equatable {
            let object: String
            let id: String
        }

        @PublicInit
        public struct DateMention: Codable, Equatable { // Renamed to avoid conflict
            let start: String
            let end: String?
            let timeZone: String?
        }

        @PublicInit
        public struct PageMention: Codable, Equatable { // Renamed to avoid conflict
            let id: String
        }
    }
}
