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

    let decoder = JSONDecoder.notion

    let encodedT = try decoder.decode(T.self, from: encoded)

    let expectedData = expected().data(using: .utf8)!
    let expectedT = try decoder.decode(T.self, from: expectedData)

    XCTAssertEqual(encodedT, expectedT, message(), file: file, line: line)
}
