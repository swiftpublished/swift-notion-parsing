@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class EmbedTests: XCTestCase {
    func test_basic() throws {
        let json: String = """
            {
                "caption": [
                    {
                        "type": "text",
                        "text": {
                            "content": "ECR Beach, Chennai",
                            "link": null
                        },
                        "annotations": {
                            "bold": false,
                            "italic": false,
                            "strikethrough": false,
                            "underline": false,
                            "code": false,
                            "color": "default"
                        },
                        "plain_text": "ECR Beach, Chennai",
                        "href": null
                    }
                ],
                "url": "https://maps.app.goo.gl/nZ1DJcEizc6ydmJKA"
            }
        """

        let expected: Block.Embed = .embed(url: "https://maps.app.goo.gl/nZ1DJcEizc6ydmJKA", caption: [.text("ECR Beach, Chennai")])

        try assert(decoding: json, to: expected)

    }
}
