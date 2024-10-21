import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys(using: .snake_case)
    struct LinkedPage: Codable, Equatable {
        public let pageId: String

        public var title: Page.Properties.Title?
    }
}
