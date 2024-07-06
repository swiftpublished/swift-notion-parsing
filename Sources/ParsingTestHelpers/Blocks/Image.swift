import Foundation
import NotionParsing

extension Block.Image {
    static func notion(url: String, expiry: String) -> Self {
        let fileType = Block.File.NotionHosted(
            url: URL(string: "https://host.com/image.png")!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )
        let file = Block.File(caption: nil, type: .notion(fileType))

        return Self(file: file)
    }

    static func external(url: String, caption: [RichText]?) -> Self {
        let fileType = Block.File.External(
            url: URL(string: "https://host.com/image.png")!
        )
        let file = Block.File(caption: nil, type: .external(fileType))

        return Self(file: file)
    }
}
