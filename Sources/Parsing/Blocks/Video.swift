import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Video: Codable, Equatable {
        public let file: File

        public init(from decoder: Decoder) throws {
            self.file = try File(from: decoder)
        }

        public func encode(to encoder: any Encoder) throws {
            try file.encode(to: encoder)
        }
    }
}
