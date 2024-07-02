import MacrosInterface

@PublicInit
public struct Block: Equatable, Identifiable {
    public let id: String
    public let hasChildren: Bool
    public let type: Types
    public var level: Int?
    public var children: [Block]?
}

public extension Block {
    enum Types: Codable, Equatable {
        case bulletedListItem(BulletedListItem)
        case heading1(Heading)
        case heading2(Heading)
        case heading3(Heading)
        case paragraph(Paragraph)
    }
}

extension Block: Codable {
    enum CodingKeys: CodingKey {
        case id
        case type
        case has_children
        case children
        case level

        enum Types: String, CodingKey, Decodable {
            case bulleted_list_item
            case heading_1
            case heading_2
            case heading_3
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
        case .heading_1:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_1)
            self.type = .heading1(heading)
        case .heading_2:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_2)
            self.type = .heading2(heading)
        case .heading_3:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_3)
            self.type = .heading3(heading)
        case .paragraph:
            let paragraph = try typesContainer.decode(Paragraph.self, forKey: .paragraph)
            self.type = .paragraph(paragraph)
        }

        self.level = try container.decodeIfPresent(Int.self, forKey: .level)
        self.children = try container.decodeIfPresent([Block].self, forKey: .children)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(hasChildren, forKey: .has_children)

        var typesContainer = encoder.container(keyedBy: CodingKeys.Types.self)
        switch self.type {
        case .bulletedListItem(let bulletedListItem):
            try container.encode(CodingKeys.Types.bulleted_list_item.rawValue, forKey: .type)
            try typesContainer.encode(bulletedListItem, forKey: .bulleted_list_item)
        case .heading1(let heading1):
            try container.encode(CodingKeys.Types.heading_1.rawValue, forKey: .type)
            try typesContainer.encode(heading1, forKey: .heading_1)
        case .heading2(let heading2):
            try container.encode(CodingKeys.Types.heading_2.rawValue, forKey: .type)
            try typesContainer.encode(heading2, forKey: .heading_2)
        case .heading3(let heading3):
            try container.encode(CodingKeys.Types.heading_3.rawValue, forKey: .type)
            try typesContainer.encode(heading3, forKey: .heading_3)
        case .paragraph(let paragraph):
            try container.encode(CodingKeys.Types.paragraph.rawValue, forKey: .type)
            try typesContainer.encode(paragraph, forKey: .paragraph)
        }

        try container.encodeIfPresent(level, forKey: .level)
        try container.encodeIfPresent(children, forKey: .children)
    }
}
