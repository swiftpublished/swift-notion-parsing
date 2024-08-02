import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Table: Codable, Equatable {
        @CodingKey(name: "table_width")
        public let tableWidth: Int

        @CodingKey(name: "has_column_header")
        public let hasColumnHeader: Bool

        @CodingKey(name: "has_row_header")
        public let hasRowHeader: Bool
    }
}
