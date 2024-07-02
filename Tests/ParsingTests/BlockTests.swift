@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class BlockTests: XCTestCase {
    func test_basic_paragraph() throws {
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

    func test_1_child_paragraph() throws {
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

    func test_nested_child_paragraph() throws {
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

    func test_basic_heading_1() throws {
        let json: String = """
        {
            "id": "59833787-2cf9-4fdf-8782-e53db20768a5",
            "type": "heading_1",
            "has_children": false,
            "heading_1": {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Heading 1",
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
                "is_toggleable": false
            }
        }
        """

        let expected: Block = .heading1(
            id: "59833787-2cf9-4fdf-8782-e53db20768a5",
            heading1: [.text("Heading 1")]
        )

        try assert(decoding: json, to: expected)
    }
}
