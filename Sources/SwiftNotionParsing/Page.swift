@PublicInit
@CodingKeys(using: .snake_case)
public struct Page: Decodable, Equatable {
    public let id: UUID
    public let lastEditedTime: Date
}
