import Foundation
import NotionParsing

extension Block.Video {
    static func notion(url: String, expiry: String) -> Self {
        let fileType = Block.File.NotionHosted(
            url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )
        let file = Block.File(caption: nil, type: .notion(fileType))

        return Self(file: file)
    }

    static func external(url: String, caption: [RichText]?) -> Self {
        let fileType = Block.File.External(
            url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
        )
        let file = Block.File(caption: nil, type: .external(fileType))

        return Self(file: file)
    }
}
