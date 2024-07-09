@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class VideoTests: XCTestCase {
    func test_basic_notion_file_decoding() throws {
        let json: String = """
        {
            "type": "file",
            "file": {
                "url": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                "expiry_time": "2024-07-04T05:37:43.648Z"
            }
        }
        """

        let expected: Block.Video = .notion(
            url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            expiry: "2024-07-04T05:37:43.648Z"
        )

        try assert(decoding: json, to: expected)
    }

    func test_basic_external_file_decoding() throws {
        let json: String = """
        {
            "type": "external",
            "external": {
                "url": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            }
        }
        """

        let expected: Block.Video = .external(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", caption: nil)

        try assert(decoding: json, to: expected)
    }

    func test_basic_notion_file_encoding() throws {
        let image: Block.Video = .notion(
            url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            expiry: "2024-07-04T05:37:43.648Z"
        )

        let expected: String = """
        {
          "file" : {
            "expiry_time" : "2024-07-04T05:37:43.648Z",
            "url" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
          },
          "type" : "file"
        }
        """

        try assert(encoding: image, to: expected)
    }

    func test_basic_external_file_encoding() throws {
        let image: Block.Video = .external(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", caption: nil)

        let expected: String = """
        {
          "external" : {
            "url" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
          },
          "type" : "external"
        }
        """

        try assert(encoding: image, to: expected)
    }
}
