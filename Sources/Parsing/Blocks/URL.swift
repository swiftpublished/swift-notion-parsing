import Foundation
import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct URL: Codable, Equatable {
        public let url: Foundation.URL
    }
}
