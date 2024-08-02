@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class TableRowTests: XCTestCase {
    func test_basic_text() throws {
        let json: String = """
        {
            "cells": [
                [
                    {
                        "type": "text",
                        "text": {
                            "content": "S No",
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
                        "plain_text": "S No",
                        "href": null
                    }
                ],
                [
                    {
                        "type": "text",
                        "text": {
                            "content": "Name",
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
                        "plain_text": "Name",
                        "href": null
                    }
                ]
            ]
        }
        """

        let expected = Block.TableRow(richTexts: [[.text("S No")], [.text("Name")]], children: nil)

        try assert(decoding: json, to: expected)
    }
}


