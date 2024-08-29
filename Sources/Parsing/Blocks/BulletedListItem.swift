import MacrosInterface

public extension Block {
    
    @CodingKeys(using: .snake_case)
    struct BulletedListItem: Codable, Equatable {
        
        @CodingKey(name: "rich_text")
        public let richTexts: [RichText]
        let children: [Block]?
    }
}
