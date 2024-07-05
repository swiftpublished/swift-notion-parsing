@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class QuoteTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
            {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Bringing ideas to life, one line of code at a time.",
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
                        "plain_text": "Bringing ideas to life, one line of code at a time.",
                        "href": null
                    }
                ],
                "color": "default"
            }
        """

        let expected = Block.Paragraph(richTexts: [.text("Bringing ideas to life, one line of code at a time.")], children: nil)

        try assert(decoding: json, to: expected)
    }

    func test_1_child() throws {
        let json: String = """
            {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Bringing ideas to life, one line of code at a time.",
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
                        "plain_text": "Bringing ideas to life, one line of code at a time.",
                        "href": null
                    }
                ],
                "children": [
                    {
                        "id": "e1caeac7-2e81-4884-81fa-422f0987edd9",
                        "type": "quote",
                        "has_children": false,
                        "quote": {
                            "rich_text": [
                                {
                                    "type": "text",
                                    "text": {
                                        "content": "The only reason we have come this far, is our community.",
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
                                    "plain_text": "The only reason we have come this far, is our community.",
                                    "href": null
                                }
                            ],
                            "color": "default"
                        }
                    }
                ]
            }
        """
        let childBlock: Block = .quote(
            id: "e1caeac7-2e81-4884-81fa-422f0987edd9",
            quote: [.text("The only reason we have come this far, is our community.")]
        )

        let expected = Block.Quote(richTexts: [.text("Bringing ideas to life, one line of code at a time.")], children: [childBlock])

        try assert(decoding: json, to: expected)
    }
}
