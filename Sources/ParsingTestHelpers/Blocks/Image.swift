import Foundation
import NotionParsing


extension Block.Image {
    static func notion(url: String, expiry: String) -> Self {
        let fileType = Block.File.NotionHosted(
            url: URL(string: url)!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )
        let file = Block.File(caption: nil, type: .notion(fileType), name: nil)

        return Self(file: file)
    }

    static func external(url: String, caption: [RichText]?) -> Self {
        let fileType = Block.File.External(
            url: URL(string: url)!
        )
        let file = Block.File(caption: caption, type: .external(fileType), name: nil)

        return Self(file: file)
    }
}
