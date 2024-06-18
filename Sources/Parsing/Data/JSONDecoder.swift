//
//  JSONDecoder.swift
//  
//
//  Created by Shahrukh Alam on 15/06/24.
//

import Foundation

public extension JSONDecoder {
    static let notion: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Notion)
        return decoder
    }()
}
