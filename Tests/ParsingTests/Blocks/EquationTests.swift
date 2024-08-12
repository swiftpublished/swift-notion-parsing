@testable import NotionParsing
@testable import NotionParsingTestHelpers
import XCTest

final class EquationTests: XCTestCase {
    func test_basic_text() throws {
        let json = """
                {
                    "expression": "e=mc^2"
                }
                """
        let expected: Block.Equation = Block.Equation(expression: "e=mc^2")
        try assert(decoding: json, to: expected)
    }
}
