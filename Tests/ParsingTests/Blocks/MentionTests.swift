@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class MentionTests: XCTestCase {
    func test_mention_user() throws {
        let json: String = """
        {
            "type": "mention",
            "mention": {
                "type": "user",
                "user": {
                    "object": "user",
                    "id": "e9370dbf-02e5-42b9-b438-58672ab8dbba"
                }
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
            },
            "plain_text": "@Anonymous",
            "href": null
        }
        """


        let expected: RichText = .mention("@Anonymous", userID: "e9370dbf-02e5-42b9-b438-58672ab8dbba")

        try assert(decoding: json, to: expected)
    }

    func test_mention_date() throws {
        let json: String = """
        {
            "type": "mention",
            "mention": {
                "type": "date",
                "date": {
                    "start": "2024-08-13",
                    "end": null,
                    "time_zone": null
                }
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
            },
            "plain_text": "2024-08-13",
            "href": null
        }
        """


        let expected: RichText = .mention( "2024-08-13", startDate: "2024-08-13")
        try assert(decoding: json, to: expected)
    }

    func test_mention_page() throws {
        let json: String = """
        {
            "type": "mention",
            "mention": {
                "type": "page",
                "page": {
                    "id": "cf5573de-e85d-41e3-aa75-e6ac1fbf15e1"
                }
            },
            "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
            },
            "plain_text": "Untitled",
            "href": "https://www.notion.so/cf5573dee85d41e3aa75e6ac1fbf15e1"
        }
        """


        let expected: RichText = .mention("Untitled", pageID: "cf5573de-e85d-41e3-aa75-e6ac1fbf15e1", href: "https://www.notion.so/cf5573dee85d41e3aa75e6ac1fbf15e1")
        try assert(decoding: json, to: expected)
    }
}
