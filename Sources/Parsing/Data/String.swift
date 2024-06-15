//
//  String.swift
//  
//
//  Created by Shahrukh Alam on 15/06/24.
//

import Foundation

public extension String {
    enum Error: Swift.Error {
        case failedToConvertStringToData
    }

    func decodeNotion<T>(_ type: T.Type) throws -> T where T: Decodable {
        guard let data = data(using: .utf8) else {
            throw Error.failedToConvertStringToData
        }

        return try JSONDecoder.notion.decode(T.self, from: data)
    }
}
