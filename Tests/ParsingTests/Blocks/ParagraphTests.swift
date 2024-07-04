@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class ParagraphTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "1",
                        "link": null
                    },
                    "annotations": {
                        "code": false,
                        "bold": false,
                        "underline": false,
                        "italic": false,
                        "strikethrough": false
                    },
                    "plain_text": "1"
                }
            ]
        }
        """

        let expected = Block.Paragraph(richTexts: [.text("1")], children: nil)

        try assert(decoding: json, to: expected)
    }

    func test_1_child() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "1",
                        "link": null
                    },
                    "annotations": {
                        "code": false,
                        "bold": false,
                        "underline": false,
                        "italic": false,
                        "strikethrough": false
                    },
                    "plain_text": "1"
                }
            ],
            "children": [
                {
                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
                    "type": "paragraph",
                    "has_children": false,
                    "paragraph": {
                        "rich_text": [
                            {
                                "type": "text",
                                "text": {
                                    "content": "1-1",
                                    "link": null
                                },
                                "annotations": {
                                    "code": false,
                                    "bold": false,
                                    "underline": false,
                                    "italic": false,
                                    "strikethrough": false
                                },
                                "plain_text": "1-1"
                            }
                        ]
                    }
                }
            ]
        }
        """

        let childBlock: Block = .paragraph(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            paragraph: [.text("1-1")]
        )

        let expected = Block.Paragraph(richTexts: [.text("1")], children: [childBlock])

        try assert(decoding: json, to: expected)
    }

    func test_nested_child() throws {
        let json: String = """
        {
            "rich_text": [
                {
                    "type": "text",
                    "text": {
                        "content": "1",
                        "link": null
                    },
                    "annotations": {
                        "code": false,
                        "bold": false,
                        "underline": false,
                        "italic": false,
                        "strikethrough": false
                    },
                    "plain_text": "1"
                }
            ],
            "children": [
                {
                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
                    "type": "paragraph",
                    "has_children": false,
                    "paragraph": {
                        "rich_text": [
                            {
                                "type": "text",
                                "text": {
                                    "content": "1-1",
                                    "link": null
                                },
                                "annotations": {
                                    "code": false,
                                    "bold": false,
                                    "underline": false,
                                    "italic": false,
                                    "strikethrough": false
                                },
                                "plain_text": "1-1"
                            }
                        ],
                        "children": [
                            {
                                "id": "9a3fbedd-070d-4c9c-8206-af688e62031e",
                                "type": "paragraph",
                                "has_children": false,
                                "paragraph": {
                                    "rich_text": [
                                        {
                                            "type": "text",
                                            "text": {
                                                "content": "1-1-1",
                                                "link": null
                                            },
                                            "annotations": {
                                                "code": false,
                                                "bold": false,
                                                "underline": false,
                                                "italic": false,
                                                "strikethrough": false
                                            },
                                            "plain_text": "1-1-1"
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                }
            ]
        }
        """

        let nestedChildBlock: Block = .paragraph(
            id: "9a3fbedd-070d-4c9c-8206-af688e62031e",
            paragraph: [.text("1-1-1")]
        )

        let childBlock: Block = .paragraph(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            paragraph: [.text("1-1")],
            paragraphChildren: [nestedChildBlock]
        )

        let expected = Block.Paragraph(richTexts: [.text("1")], children: [childBlock])

        try assert(decoding: json, to: expected)
    }
}
