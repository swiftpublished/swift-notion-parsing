@testable import NotionParsing
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
                    }
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
                    }
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
                                }
                            }
                        ]
                    }
                }
            ]
        }
        """

        let childParagraph = Block.Paragraph(richTexts: [.text("1-1")], children: nil)
        let childBlock = Block(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            hasChildren: false,
            type: .paragraph(childParagraph),
            children: nil
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
                    }
                }
            ],
            "children": [
                {
                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
                    "type": "paragraph",
                    "has_children": true,
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
                                }
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
                                            }
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

        let nestedChildParagraph = Block.Paragraph(richTexts: [.text("1-1-1")], children: nil)
        let nestedChildBlock = Block(
            id: "9a3fbedd-070d-4c9c-8206-af688e62031e",
            hasChildren: false,
            type: .paragraph(nestedChildParagraph),
            children: nil
        )

        let childParagraph = Block.Paragraph(richTexts: [.text("1-1")], children: [nestedChildBlock])
        let childBlock = Block(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            hasChildren: true,
            type: .paragraph(childParagraph),
            children: nil
        )

        let expected = Block.Paragraph(richTexts: [.text("1")], children: [childBlock])

        try assert(decoding: json, to: expected)
    }
}
