import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys(using: .snake_case)
    struct TableRow: Codable, Equatable {
        @CodingKey(name: "cells")
        public let richTexts: [[RichText]]

        let children: [Block]?
    }
}
