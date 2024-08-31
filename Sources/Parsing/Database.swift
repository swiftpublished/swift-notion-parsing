import Foundation
import MacrosInterface

@CodingKeys
public struct Database: Codable {
    @CodingKey(name: "results")
    public var pages: [Page]
}
