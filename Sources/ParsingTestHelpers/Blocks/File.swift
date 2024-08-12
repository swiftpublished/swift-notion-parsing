import Foundation
import NotionParsing

extension Block.File {
    static func notion(url: String, expiry: String, caption: [RichText]?, name: String) -> Self {
        let fileType = Block.File.NotionHosted(
            url: URL(string: url)!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )

        return Self(caption: caption, type: .notion(fileType), name: name)
    }

    static func external(url: String, caption: [RichText]?, name: String) -> Self {
        let fileType = Block.File.External(
            url: URL(string: url)!
        )

        return Self(caption: caption, type: .external(fileType), name: name)
    }
}
