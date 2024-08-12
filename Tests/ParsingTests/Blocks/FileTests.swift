@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class FileTests: XCTestCase {
    func test_basic_notion_file_decoding() throws {
        let json = """
            {
                "caption": [],
                "type": "file",
                "file": {
                    "url": "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/e08ac287-de3b-4042-9a20-18c56d9335ed/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240811%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240811T191551Z&X-Amz-Expires=3600&X-Amz-Signature=c644f42e045e145dcf69af9ef2e69246005bd4d283f6b53cde21f14d786adc60&X-Amz-SignedHeaders=host&x-id=GetObject",
                    "expiry_time": "2024-08-11T20:15:51.484Z"
                },
                "name": "Kanagasabapathy_iOS.pdf"
            }
        """
        let expected: Block.File = .notion(
            url: "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/e08ac287-de3b-4042-9a20-18c56d9335ed/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240811%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240811T191551Z&X-Amz-Expires=3600&X-Amz-Signature=c644f42e045e145dcf69af9ef2e69246005bd4d283f6b53cde21f14d786adc60&X-Amz-SignedHeaders=host&x-id=GetObject",
            expiry: "2024-08-11T20:15:51.484Z",
            caption: [],
            name: "Kanagasabapathy_iOS.pdf")

        try assert(decoding: json, to: expected)
    }

    func test_basic_notion_file_encoding() throws {

        let file: Block.File = .notion(
            url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            expiry: "2024-08-11T20:15:51.484Z",
            caption: [],
            name: "Kanagasabapathy_iOS.pdf")


        let expected: String = """
            {
              "caption" : [

              ],
              "file" : {
                "expiry_time" : "2024-08-11T20:15:51.484Z",
                "url" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
              },
              "name" : "Kanagasabapathy_iOS.pdf",
              "type" : "file"
            }
            """

        try assert(encoding: file, to: expected)
    }

    func test_basic_external_file_decoding() throws {
        let json = """
        {
          "caption" : [

          ],
          "external" : {
            "url" : "https://sabapathy7.medium.com"
          },
          "name" : "sabapathy7.medium.com",
          "type" : "external"
        }
        """
        let expected: Block.File = .external(url: "https://sabapathy7.medium.com",
                                             caption: [],
                                             name: "sabapathy7.medium.com")

        try assert(decoding: json, to: expected)
    }

    func test_basic_external_file_encoding() throws {
        let file: Block.File = .external(url: "https://sabapathy7.medium.com",
                                          caption: [],
                                          name: "sabapathy7.medium.com")

        let expected: String = """
        {
          "caption" : [

          ],
          "external" : {
            "url" : "https://sabapathy7.medium.com"
          },
          "name" : "sabapathy7.medium.com",
          "type" : "external"
        }
        """

        try assert(encoding: file, to: expected)
    }
}
