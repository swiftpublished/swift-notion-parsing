@testable import NotionParsing
import XCTest

final class BlockTests: XCTestCase {
    func test_basic() throws {
        let json: String = """
        {
            "id": "59833787-2cf9-4fdf-8782-e53db20768a5",
            "type": "paragraph",
            "has_children": false,
            "paragraph": {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Paragraph",
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
        """

        let expected: Block = .paragraph(
            id: "59833787-2cf9-4fdf-8782-e53db20768a5",
            paragraph: [.text("Paragraph")]
        )

        try assert(decoding: json, to: expected)
    }

    func test_1_child() throws {
        let json: String = """
        {
            "id": "51899e33-4e7c-4de9-a68b-ce5c08aabe85",
            "type": "paragraph",
            "has_children": true,
            "paragraph": {
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
            },
            "children": [
                {
                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
                    "type": "paragraph",
                    "has_children": false,
                    "level": 1,
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

        let childBlock: Block = .paragraph(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            level: 1,
            paragraph: [.text("1-1")]
        )

        let expected: Block = .paragraph(
            id: "51899e33-4e7c-4de9-a68b-ce5c08aabe85",
            hasChildren: true,
            paragraph: [.text("1")],
            blockChildren: [childBlock]
        )

        try assert(decoding: json, to: expected)
    }

    func test_nested_child() throws {
        let json: String = """
        {
            "id": "51899e33-4e7c-4de9-a68b-ce5c08aabe85",
            "type": "paragraph",
            "has_children": true,
            "paragraph": {
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
            },
            "children": [
                {
                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
                    "type": "paragraph",
                    "has_children": true,
                    "level": 1,
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
                    },
                    "children": [
                        {
                            "id": "9a3fbedd-070d-4c9c-8206-af688e62031e",
                            "type": "paragraph",
                            "has_children": false,
                            "level": 2,
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
            ]
        }
        """

        let nestedChildBlock: Block = .paragraph(
            id: "9a3fbedd-070d-4c9c-8206-af688e62031e",
            level: 2,
            paragraph: [.text("1-1-1")]
        )

        let childBlock: Block = .paragraph(
            id: "88ac35b2-7928-4229-8f6a-db802d3f498e",
            hasChildren: true,
            level: 1,
            paragraph: [.text("1-1")],
            blockChildren: [nestedChildBlock]
        )

        let expected: Block = .paragraph(
            id: "51899e33-4e7c-4de9-a68b-ce5c08aabe85",
            hasChildren: true,
            paragraph: [.text("1")],
            blockChildren: [childBlock]
        )

        try assert(decoding: json, to: expected)
    }
}

extension Block {
    static func paragraph(
        id: String,
        hasChildren: Bool = false,
        level: Int? = nil,
        paragraph: [RichText],
        paragraphChildren: [Block]? = nil,
        blockChildren: [Block]? = nil
    ) -> Self {
        let paragraph = Block.Paragraph(richTexts: paragraph, children: paragraphChildren)
        let block = Block(
            id: id,
            hasChildren: hasChildren,
            type: .paragraph(paragraph),
            level: level,
            children: blockChildren
        )
        return block
    }
}
