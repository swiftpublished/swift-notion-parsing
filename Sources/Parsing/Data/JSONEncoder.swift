//
//  File.swift
//  
//
//  Created by Shahrukh Alam on 06/07/24.
//

import Foundation

public extension JSONEncoder {
    static let notion: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.iso8601Notion)
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
        return encoder
    }()
}
