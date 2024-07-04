import Foundation
import NotionParsing

extension Block.Image {
    static func notionFile(url: String, expiry: String) -> Self {
        let file = Types.NotionHostedFile(
            url: URL(string: "https://host.com/image.png")!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )

        return Self(caption: nil, type: .file(file))
    }

    static func externalFile(url: String) -> Self {
        let file = Types.ExternalFile(
            url: URL(string: "https://host.com/image.png")!
        )

        return Self(caption: nil, type: .external(file))
    }
}
