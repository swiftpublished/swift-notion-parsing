@testable import NotionParsing
import XCTest

final class Heading1Tests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "rich_text": [{
              "type": "text",
              "text": {
                "content": "Lacinato kale",
                "link": null
              }
            }],
            "color": "default",
            "is_toggleable": false
          }
        """

        let expected = Block.Heading1(richTexts: [.text("Lacinato kale", annotations: .none)], isToggleable: false)
        try assert(decoding: json, to: expected)
    }
}
