import Foundation
import SwiftMacrosInterface

@CodingKeys
public struct Page: Decodable {
    public let id: String

    @CodingKey(name: "last_edited_time")
    public let lastEditedTime: Date
}
