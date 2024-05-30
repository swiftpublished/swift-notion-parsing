public struct Block {
    public let id: String
    public let hasChildren: Bool
    let type: Types
    public var children: [Block]?
}

extension Block {
    enum Types: Decodable {
        case paragraph(Paragraph)
        case bulletedListItem(BulletedListItem)
    }
}

extension Block: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case type
        case has_children

        enum Types: String, CodingKey, Decodable {
            case bulleted_list_item
            case paragraph
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.hasChildren = try container.decode(Bool.self, forKey: .has_children)

        let type = try container.decode(CodingKeys.Types.self, forKey: .type)
        let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
        switch type {
        case .bulleted_list_item:
            let bulletedListItem = try typesContainer.decode(BulletedListItem.self, forKey: .bulleted_list_item)
            self.type = .bulletedListItem(bulletedListItem)
        case .paragraph:
            let paragraph = try typesContainer.decode(Paragraph.self, forKey: .paragraph)
            self.type = .paragraph(paragraph)
        }
    }
}
