@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class TableTests: XCTestCase {
    func test_basic_text() throws {
        let json = """
                {
                    "type": "table",
                    "table": {
                        "table_width": 2,
                        "has_column_header": true,
                        "has_row_header": true
                    }
                }
                """
        let expected: Block.Table = .createSampleTableData(tableWidth: 2, hasColumnHeader: true, hasRowHeader: true)
        try assert(decoding: json, to: expected)
    }
}
