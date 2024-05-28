struct Block {
    let id: String
    let type: Types
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

        enum Types: String, CodingKey, Decodable {
            case bulletedListItem = "bulleted_list_item"
            case paragraph
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)

        let type = try container.decode(CodingKeys.Types.self, forKey: .type)
        let typesContainer = try decoder.container(keyedBy: CodingKeys.Types.self)
        switch type {
        case .bulletedListItem:
            let bulletedListItem = try typesContainer.decode(BulletedListItem.self, forKey: .bulletedListItem)
            self.type = .bulletedListItem(bulletedListItem)
        case .paragraph:
            let paragraph = try typesContainer.decode(Paragraph.self, forKey: .paragraph)
            self.type = .paragraph(paragraph)
        }
    }
}
