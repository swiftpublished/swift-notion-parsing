import Foundation
import NotionParsing

extension Block.Equation {
    static func createSampleEquation(expression: String) -> Self {
        return Self(expression: expression)
    }
}
