import MacrosInterface

public extension Block {
    @CodingKeys(using: .snake_case)
    struct BulletedListItem: Codable, Equatable {
        let richText: [RichText]
        let children: [Block]?
    }
}
