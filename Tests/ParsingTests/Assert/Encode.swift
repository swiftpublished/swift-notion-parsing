import Foundation
import XCTest
@testable import NotionParsing

func assert<T>(
    encoding data: T,
    to expected: @autoclosure () -> String,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws where T: Codable, T: Equatable {
    let encoder = JSONEncoder.notion
    let encoded = try encoder.encode(data)
    let json = String(data: encoded, encoding: .utf8)!

    XCTAssertEqual(json, expected(), message(), file: file, line: line)
}
