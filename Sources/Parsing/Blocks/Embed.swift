import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Embed: Codable, Equatable {
        public let url: URL
    }
}
