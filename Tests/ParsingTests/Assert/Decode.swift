import Foundation
import XCTest
@testable import NotionParsing

func assert<T>(
    decoding json: String,
    to expected: @autoclosure () -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws where T: Decodable, T: Equatable {
    let data = json.data(using: .utf8)!
    let decoder = JSONDecoder.notion
    let decoded = try decoder.decode(T.self, from: data)

    XCTAssertEqual(decoded, expected(), message(), file: file, line: line)
}
