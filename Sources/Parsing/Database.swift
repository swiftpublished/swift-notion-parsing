import Foundation
import MacrosInterface

@CodingKeys
public struct Database<Page>: Codable where Page: Codable {
    @CodingKey(name: "results")
    public var pages: [Page]
}
