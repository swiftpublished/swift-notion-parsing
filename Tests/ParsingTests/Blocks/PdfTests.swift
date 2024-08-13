@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class PdfTests: XCTestCase {
    func test_basic_notion_pdf_file_decoding() throws {
        let json: String = """
        {
            "caption": [],
            "type": "file",
            "file": {
                "url": "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/9c6298a6-c991-419f-a4c8-252174a0c5a3/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240812%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240812T035443Z&X-Amz-Expires=3600&X-Amz-Signature=d6d3d40e0ab3b2528686ba67a213d2471a0437522153386c8d314ef01f2bf917&X-Amz-SignedHeaders=host&x-id=GetObject",
                "expiry_time": "2024-08-12T04:54:42.912Z"
            }
        }
        """
        let expected: Block.Pdf = .notion(
            caption: [],
            url: "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/9c6298a6-c991-419f-a4c8-252174a0c5a3/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240812%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240812T035443Z&X-Amz-Expires=3600&X-Amz-Signature=d6d3d40e0ab3b2528686ba67a213d2471a0437522153386c8d314ef01f2bf917&X-Amz-SignedHeaders=host&x-id=GetObject",
            expiry: "2024-08-12T04:54:42.912Z")

        try assert(decoding: json, to: expected)
    }

    func test_basic_notion_pdf_file_encoding() throws {

        let pdf: Block.Pdf = .notion(
            caption: [],
            url: "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/9c6298a6-c991-419f-a4c8-252174a0c5a3/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240812%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240812T035443Z&X-Amz-Expires=3600&X-Amz-Signature=d6d3d40e0ab3b2528686ba67a213d2471a0437522153386c8d314ef01f2bf917&X-Amz-SignedHeaders=host&x-id=GetObject",
            expiry: "2024-08-11T20:15:51.484Z")


        let expected: String = """
            {
              "caption" : [

              ],
              "file" : {
                "expiry_time" : "2024-08-11T20:15:51.484Z",
                "url" : "https://prod-files-secure.s3.us-west-2.amazonaws.com/fc6895ab-d805-4f0f-935f-921e84f89b37/9c6298a6-c991-419f-a4c8-252174a0c5a3/Kanagasabapathy_iOS.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240812%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240812T035443Z&X-Amz-Expires=3600&X-Amz-Signature=d6d3d40e0ab3b2528686ba67a213d2471a0437522153386c8d314ef01f2bf917&X-Amz-SignedHeaders=host&x-id=GetObject"
              },
              "type" : "file"
            }
            """

        try assert(encoding: pdf, to: expected)
    }

    func test_basic_external_pdf_file_decoding() throws {
        let json: String = """
        {
          "caption" : [

          ],
          "external" : {
            "url" : "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf"
          },
          "type" : "external"
        }
        """
        let expected: Block.Pdf = .external(url: "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf",
                                             caption: [])

        try assert(decoding: json, to: expected)
    }

    func test_basic_external_pdf_file_encoding() throws {
        let pdf: Block.Pdf = .external(url: "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf",
                                          caption: [])

        let expected: String = """
        {
          "caption" : [

          ],
          "external" : {
            "url" : "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf"
          },
          "type" : "external"
        }
        """

        try assert(encoding: pdf, to: expected)
    }
}


