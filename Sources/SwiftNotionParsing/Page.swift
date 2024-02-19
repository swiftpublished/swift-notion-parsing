@PublicInit
@CodingKeys
public struct Page: Decodable, Equatable {
    public let id: UUID

    @CodingKey(name: "last_edited_time")
    public let lastEditedTime: Date
}
