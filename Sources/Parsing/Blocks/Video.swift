import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Video: Codable, Equatable {
        public let file: File
        public let type: Types

        public enum Types {
            case youtube
            case vimeo
            case unknown
        }

        public init(from decoder: Decoder) throws {
            self.file = try File(from: decoder)

            if let host = file.type.url.host() {
                switch host {
                case let host where host.contains("youtube.com"):
                    self.type = .youtube
                case let host where host.contains("vimeo.com"):
                    self.type = .vimeo
                default:
                    self.type = .unknown
                }
            } else {
                self.type = .unknown
            }
        }

        public func encode(to encoder: any Encoder) throws {
            try file.encode(to: encoder)
        }
    }
}
