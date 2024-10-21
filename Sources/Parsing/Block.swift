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
        case callout(Callout)
        case code(Code)
        case divider(Divider)
        case embed(Embed)
        case equation(Equation)
        case file(File)
        case heading1(Heading)
        case heading2(Heading)
        case heading3(Heading)
        case image(Image)
        case linkedPage(LinkedPage)
        case numberedListItem(NumberedListItem)
        case paragraph(Paragraph)
        case pdf(Pdf)
        case quote(Quote)
        case table(Table)
        case tableRow(TableRow)
        case todo(Todo)
        case toggle(Toggle)
        case video(Video)
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
            case callout
            case code
            case divider
            case embed
            case equation
            case file
            case heading_1
            case heading_2
            case heading_3
            case image
            case link_to_page
            case numbered_list_item
            case paragraph
            case pdf
            case quote
            case table
            case tableRow
            case todo
            case toggle
            case video
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
        case .callout:
            let callout = try typesContainer.decode(Callout.self, forKey: .callout)
            self.type = .callout(callout)
        case .code:
            let code = try typesContainer.decode(Code.self, forKey: .code)
            self.type = .code(code)
        case .divider:
            let divider = try typesContainer.decode(Divider.self, forKey: .divider)
            self.type = .divider(divider)
        case .embed:
            let embed = try typesContainer.decode(Embed.self, forKey: .embed)
            self.type = .embed(embed)
        case .equation:
            let equation = try typesContainer.decode(Equation.self, forKey: .equation)
            self.type = .equation(equation)
        case .file:
            let file = try typesContainer.decode(File.self, forKey: .file)
            self.type = .file(file)
        case .heading_1:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_1)
            self.type = .heading1(heading)
        case .heading_2:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_2)
            self.type = .heading2(heading)
        case .heading_3:
            let heading = try typesContainer.decode(Heading.self, forKey: .heading_3)
            self.type = .heading3(heading)
        case .image:
            let image = try typesContainer.decode(Image.self, forKey: .image)
            self.type = .image(image)
        case .link_to_page:
            let page = try typesContainer.decode(LinkedPage.self, forKey: .link_to_page)
            self.type = .linkedPage(page)
        case .numbered_list_item:
            let numberedListItem = try typesContainer.decode(NumberedListItem.self, forKey: .numbered_list_item)
            self.type = .numberedListItem(numberedListItem)
        case .paragraph:
            let paragraph = try typesContainer.decode(Paragraph.self, forKey: .paragraph)
            self.type = .paragraph(paragraph)
        case .pdf:
            let pdf = try typesContainer.decode(Pdf.self, forKey: .pdf)
            self.type = .pdf(pdf)
        case .quote:
            let quote = try typesContainer.decode(Quote.self, forKey: .quote)
            self.type = .quote(quote)
        case .table:
            let table = try typesContainer.decode(Table.self, forKey: .table)
            self.type = .table(table)
        case .tableRow:
            let tableRow = try typesContainer.decode(TableRow.self, forKey: .tableRow)
            self.type = .tableRow(tableRow)
        case .todo:
            let todo = try typesContainer.decode(Todo.self, forKey: .tableRow)
            self.type = .todo(todo)
        case .toggle:
            let toggle = try typesContainer.decode(Toggle.self, forKey: .toggle)
            self.type = .toggle(toggle)
        case .video:
            let video = try typesContainer.decode(Video.self, forKey: .video)
            self.type = .video(video)
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
        case .callout(let callout):
            try container.encode(CodingKeys.Types.callout.rawValue, forKey: .type)
            try typesContainer.encode(callout, forKey: .callout)
        case .code(let code):
            try container.encode(CodingKeys.Types.code.rawValue, forKey: .type)
            try typesContainer.encode(code, forKey: .code)
        case .divider(let divider):
            try container.encode(CodingKeys.Types.divider.rawValue, forKey: .type)
            try typesContainer.encode(divider, forKey: .divider)
        case .embed(let embed):
            try container.encode(CodingKeys.Types.embed.rawValue, forKey: .type)
            try typesContainer.encode(embed, forKey: .embed)
        case .equation(let equation):
            try container.encode(CodingKeys.Types.equation.rawValue, forKey: .type)
            try typesContainer.encode(equation, forKey: .equation)
        case .file(let file):
            try container.encode(CodingKeys.Types.file.rawValue, forKey: .type)
            try typesContainer.encode(file, forKey: .file)
        case .heading1(let heading1):
            try container.encode(CodingKeys.Types.heading_1.rawValue, forKey: .type)
            try typesContainer.encode(heading1, forKey: .heading_1)
        case .heading2(let heading2):
            try container.encode(CodingKeys.Types.heading_2.rawValue, forKey: .type)
            try typesContainer.encode(heading2, forKey: .heading_2)
        case .heading3(let heading3):
            try container.encode(CodingKeys.Types.heading_3.rawValue, forKey: .type)
            try typesContainer.encode(heading3, forKey: .heading_3)
        case .image(let image):
            try container.encode(CodingKeys.Types.image.rawValue, forKey: .type)
            try typesContainer.encode(image, forKey: .image)
        case .linkedPage(let page):
            try container.encode(CodingKeys.Types.link_to_page.rawValue, forKey: .type)
            try typesContainer.encode(page, forKey: .link_to_page)
        case .numberedListItem(let numberedListItem):
            try container.encode(CodingKeys.Types.numbered_list_item.rawValue, forKey: .type)
            try typesContainer.encode(numberedListItem, forKey: .numbered_list_item)
        case .paragraph(let paragraph):
            try container.encode(CodingKeys.Types.paragraph.rawValue, forKey: .type)
            try typesContainer.encode(paragraph, forKey: .paragraph)
        case .pdf(let pdf):
            try container.encode(CodingKeys.Types.pdf.rawValue, forKey: .type)
            try typesContainer.encode(pdf, forKey: .pdf)
        case .quote(let quote):
            try container.encode(CodingKeys.Types.quote.rawValue, forKey: .type)
            try typesContainer.encode(quote, forKey: .quote)
        case .table(let table):
            try container.encode(CodingKeys.Types.table.rawValue, forKey: .type)
            try typesContainer.encode(table, forKey: .table)
        case .tableRow(let tableRow):
            try container.encode(CodingKeys.Types.tableRow.rawValue, forKey: .type)
            try typesContainer.encode(tableRow, forKey: .tableRow)
        case .todo(let todo):
            try container.encode(CodingKeys.Types.todo.rawValue, forKey: .type)
            try typesContainer.encode(todo, forKey: .todo)
        case .toggle(let toggle):
            try container.encode(CodingKeys.Types.toggle.rawValue, forKey: .type)
            try typesContainer.encode(toggle, forKey: .toggle)
        case .video(let video):
            try container.encode(CodingKeys.Types.video.rawValue, forKey: .type)
            try typesContainer.encode(video, forKey: .video)
        }

        try container.encodeIfPresent(level, forKey: .level)
        try container.encodeIfPresent(children, forKey: .children)
    }
}
