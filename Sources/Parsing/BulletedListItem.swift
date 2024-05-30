import MacrosInterface

extension Block {
    @CodingKeys(using: .snake_case)
    struct BulletedListItem: Decodable {
        let richText: [RichText]
        let children: [Block]?
    }
}
