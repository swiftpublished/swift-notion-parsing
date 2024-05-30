import MacrosInterface

extension Block {
    @CodingKeys(using: .snake_case)
    struct Paragraph: Decodable {
        let richText: [RichText]
        let children: [Block]?
    }
}

/// **For Testing**
//[
//    {
//        "id": "51899e33-4e7c-4de9-a68b-ce5c08aabe85",
//        "type": "paragraph",
//        "paragraph": {
//            "rich_text": [
//                {
//                    "type": "text",
//                    "text": {
//                        "content": "1",
//                        "link": null
//                    },
//                    "annotations": {
//                        "code": false,
//                        "bold": false,
//                        "underline": false,
//                        "italic": false,
//                        "strikethrough": false
//                    }
//                }
//            ],
//            "children": [
//                {
//                    "id": "88ac35b2-7928-4229-8f6a-db802d3f498e",
//                    "type": "paragraph",
//                    "paragraph": {
//                        "rich_text": [
//                            {
//                                "type": "text",
//                                "text": {
//                                    "content": "1-1",
//                                    "link": null
//                                },
//                                "annotations": {
//                                    "code": false,
//                                    "bold": false,
//                                    "underline": false,
//                                    "italic": false,
//                                    "strikethrough": false
//                                }
//                            }
//                        ],
//                        "children": [
//                            {
//                                "id": "9a3fbedd-070d-4c9c-8206-af688e62031e",
//                                "type": "paragraph",
//                                "paragraph": {
//                                    "rich_text": [
//                                        {
//                                            "type": "text",
//                                            "text": {
//                                                "content": "1-1-1",
//                                                "link": null
//                                            },
//                                            "annotations": {
//                                                "code": false,
//                                                "bold": false,
//                                                "underline": false,
//                                                "italic": false,
//                                                "strikethrough": false
//                                            }
//                                        }
//                                    ]
//                                }
//                            }
//                        ]
//                    }
//                }
//            ]
//        }
//    }
//]
