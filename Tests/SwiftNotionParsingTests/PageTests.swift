final class PageTests: XCTestCase {
    func testBasicPage() throws {
        let json: String = """
        {
            "id": "59833787-2cf9-4fdf-8782-e53db20768a5",
            "last_edited_time": "2020-03-17T19:10:04.968Z"
        }
        """

        let expected = Page(
            id: UUID(uuidString: "59833787-2cf9-4fdf-8782-e53db20768a5")!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: "2020-03-17T19:10:04.968Z")!
        )

        try assert(decoding: json, to: expected)
    }
}
