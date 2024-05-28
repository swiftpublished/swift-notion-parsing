@testable import SwiftNotionParsing
import XCTest

final class RichTextTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "This is an ",
                "link": null
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false
            }
        }
        """

        let text = RichText.Types.Text(content: "This is an ", link: nil)
        let annotations = RichText.Annotations(
            bold: false,
            italic: false,
            strikethrough: false,
            underline: false,
            code: false
        )
        let expected = RichText(type: .text(text), annotations: annotations)

        try assert(decoding: json, to: expected)
    }

    func test_text_with_link() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "This is an ",
                "link": {
                    "url": "https://developers.notion.com/"
                }
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false
            }
        }
        """

        let link = RichText.Types.Text.Link(url: URL(string: "https://developers.notion.com/")!)
        let text = RichText.Types.Text(content: "This is an ", link: link)
        let annotations = RichText.Annotations(
            bold: false,
            italic: false,
            strikethrough: false,
            underline: false,
            code: false
        )
        let expected = RichText(type: .text(text), annotations: annotations)

        try assert(decoding: json, to: expected)
    }
}
