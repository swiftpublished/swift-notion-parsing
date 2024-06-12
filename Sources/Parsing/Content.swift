import MacrosInterface

@PublicInit
@CodingKeys(using: .snake_case)
public struct Content: Codable, Equatable {
    public let nextCursor: String?
    public let hasMore: Bool

    @CodingKey(name: "results")
    public var blocks: [Block]
}
