import MacrosInterface

@PublicInit
public struct Block: Equatable {
    public let id: String
    public let hasChildren: Bool
    public let type: Types
    public var children: [Block]?
}

public extension Block {
    enum Types: Codable, Equatable {
        case paragraph(Paragraph)
        case bulletedListItem(BulletedListItem)
    }
}

extension Block: Codable {
    enum CodingKeys: CodingKey {
        case id
        case type
        case has_children
        case children

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

    public func encode(to encoder: any Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(hasChildren, forKey: .has_children)

        var typesContainer = try encoder.container(keyedBy: CodingKeys.Types.self)
        switch self.type {
        case .paragraph(let paragraph):
            try container.encode(CodingKeys.Types.paragraph.rawValue, forKey: .type)
            try typesContainer.encode(paragraph, forKey: .paragraph)
        case .bulletedListItem(let bulletedListItem):
            try container.encode(CodingKeys.Types.bulleted_list_item.rawValue, forKey: .type)
            try typesContainer.encode(bulletedListItem, forKey: .bulleted_list_item)
        }

        try container.encodeIfPresent(children, forKey: .children)
    }
}
