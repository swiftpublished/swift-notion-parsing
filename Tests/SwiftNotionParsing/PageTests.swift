import XCTest
@testable import SwiftNotionParsing

final class PageTests: XCTestCase {
    func testPage() throws {
        let json: String = """
        {
            "id": "59833787-2cf9-4fdf-8782-e53db20768a5",
            "last_edited_time": "2022-07-06T20:25:00.000Z"
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let page: Page = try decoder.decode(Page.self, from: data)
        XCTAssertEqual(page.id, "59833787-2cf9-4fdf-8782-e53db20768a5")
    }
}
