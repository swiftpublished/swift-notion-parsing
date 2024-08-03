@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class CalloutTests: XCTestCase {
    
    func test_basic_emoji_decoding() throws {
        let json: String = """
            {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Lifetime Warranty",
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
                        "plain_text": "Lifetime Warranty",
                        "href": null
                    }
                ],
                "icon": {
                    "type": "emoji",
                    "emoji": "💡"
                },
                "color": "gray_background"
            }
        """
        
        let expected: Block.Callout = .emoji(emoji: "💡", richTexts: [.text("Lifetime Warranty")])
        try assert(decoding: json, to: expected)
    }
    
    
    func test_basic_notion_file_decoding() throws {
        let json: String = """
            {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Swift Programming",
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
                        "plain_text": "Swift Programming",
                        "href": null
                    }
                ],
                "icon": {
                    "type": "file",
                    "file": {
                        "url": "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/fd3ef294-6451-4a59-9088-aadbced9b9d3/SwiftLogo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240803%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240803T032103Z&X-Amz-Expires=3600&X-Amz-Signature=b209ac7b79a13d9c64feaf298e9b05ad1c0f8ee93631c38ff968f9f899e13044&X-Amz-SignedHeaders=host&x-id=GetObject",
                        "expiry_time": "2024-08-03T04:21:03.652Z"
                    }
                }
            }
        """
        
        let expected: Block.Callout = .notion(
            url: "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/fd3ef294-6451-4a59-9088-aadbced9b9d3/SwiftLogo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240803%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240803T032103Z&X-Amz-Expires=3600&X-Amz-Signature=b209ac7b79a13d9c64feaf298e9b05ad1c0f8ee93631c38ff968f9f899e13044&X-Amz-SignedHeaders=host&x-id=GetObject",
            expiry: "2024-08-03T04:21:03.652Z",
            richTexts: [.text("Swift Programming")]
        )
        
        try assert(decoding: json, to: expected)
    }
    
    func test_basic_external_file_decoding() throws {
        let json: String = """
            {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "Free Shipping",
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
                        "plain_text": "Free Shipping",
                        "href": null
                    }
                ],
                "icon": {
                    "type": "external",
                    "external": {
                        "url": "https://www.notion.so/icons/airplane_yellow.svg"
                    }
                }
            }
        """
        
        let expected: Block.Callout = .external(url: "https://www.notion.so/icons/airplane_yellow.svg", richTexts: [.text("Free Shipping")])
        try assert(decoding: json, to: expected)
    }
    
    
    func test_basic_notion_file_encoding() throws {
        let callout: Block.Callout = .notion(
            url: "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/fd3ef294-6451-4a59-9088-aadbced9b9d3/SwiftLogo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240803%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240803T032103Z&X-Amz-Expires=3600&X-Amz-Signature=b209ac7b79a13d9c64feaf298e9b05ad1c0f8ee93631c38ff968f9f899e13044&X-Amz-SignedHeaders=host&x-id=GetObject",
            expiry: "2024-07-04T05:37:43.648Z",
            richTexts: [.text("Swift Programming")]
        )
        
        let expected: String = """
        {
          "icon" : {
            "file" : {
              "expiry_time" : "2024-07-04T05:37:43.648Z",
              "url" : "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/fd3ef294-6451-4a59-9088-aadbced9b9d3/SwiftLogo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240803%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240803T032103Z&X-Amz-Expires=3600&X-Amz-Signature=b209ac7b79a13d9c64feaf298e9b05ad1c0f8ee93631c38ff968f9f899e13044&X-Amz-SignedHeaders=host&x-id=GetObject"
            },
            "type" : "file"
          },
          "rich_text" : [
            {
              "annotations" : {
                "bold" : false,
                "code" : false,
                "italic" : false,
                "strikethrough" : false,
                "underline" : false
              },
              "plain_text" : "Swift Programming",
              "text" : {
                "content" : "Swift Programming"
              },
              "type" : "text"
            }
          ]
        }
        """
        
        try assert(encoding: callout, to: expected)
    }
    
    func test_basic_external_file_encoding() throws {
        let callout: Block.Callout = .external(url: "https://www.notion.so/icons/airplane_yellow.svg", richTexts: [.text("Free Shipping")])
        
        let expected: String = """
        {
          "icon" : {
            "external" : {
              "url" : "https://www.notion.so/icons/airplane_yellow.svg"
            },
            "type" : "external"
          },
          "rich_text" : [
            {
              "annotations" : {
                "bold" : false,
                "code" : false,
                "italic" : false,
                "strikethrough" : false,
                "underline" : false
              },
              "plain_text" : "Free Shipping",
              "text" : {
                "content" : "Free Shipping"
              },
              "type" : "text"
            }
          ]
        }
        """
        
        try assert(encoding: callout, to: expected)
    }
}
