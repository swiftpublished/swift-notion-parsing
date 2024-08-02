import Foundation
import NotionParsing

extension Block.Table {
   static func createSampleTableData(tableWidth: Int,
                               hasColumnHeader: Bool,
                               hasRowHeader: Bool) -> Self {
        return Self(tableWidth: tableWidth,
                    hasColumnHeader: hasColumnHeader,
                    hasRowHeader: hasRowHeader
        )
    }
}
