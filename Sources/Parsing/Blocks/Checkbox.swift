import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Checkbox: Codable, Equatable {
        @CodingKey(name: "checkbox")
        public let isSelected: Bool
    }
}
