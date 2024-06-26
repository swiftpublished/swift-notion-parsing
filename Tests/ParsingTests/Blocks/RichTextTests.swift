@testable import NotionParsing
import XCTest

final class RichTextTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "Paragraph",
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

        let expected: RichText = .text("Paragraph")

        try assert(decoding: json, to: expected)
    }

    func test_text_with_link() throws {
        let json: String = """
        {
            "type": "text",
            "text": {
                "content": "Paragraph",
                "link": {
                    "url": "https://developers.notion.com"
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

        let expected: RichText = .text("Paragraph", link: "https://developers.notion.com")

        try assert(decoding: json, to: expected)
    }
}

extension RichText {
    static func text(_ text: String, annotations: RichText.Annotations? = .normal) -> Self {
        let text = RichText.Types.Text(content: text, link: nil)
        return RichText(type: .text(text), annotations: annotations)
    }

    static func text(_ text: String, link: String) -> Self {
        let link = RichText.Types.Text.Link(url: URL(string: link)!)
        let text = RichText.Types.Text(content: text, link: link)
        return RichText(type: .text(text), annotations: .normal)
    }
}

extension RichText.Annotations {
    static var normal: Self {
        Self(
            bold: false,
            italic: false,
            strikethrough: false,
            underline: false,
            code: false
        )
    }
    static var none: Self? {
        return nil
    }
}
