import MacrosInterface

@CodingKeys(using: .snake_case)
public struct Content: Decodable {
    public let nextCursor: String?
    public let hasMore: Bool
    public var results: [Block]
}
