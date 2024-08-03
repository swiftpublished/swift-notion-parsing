import Foundation
import NotionParsing

extension Block.Callout {
    static func notion(url: String, expiry: String, richTexts: [RichText]) -> Self {
        let fileType = Block.Icon.NotionHosted(
            url: URL(string: url)!,
            expiryTime: DateFormatter.iso8601Notion.date(from: expiry)!
        )
        let file = Block.Icon(type: .notion(fileType))

        return Self(richTexts: richTexts, icon: file)
    }

    static func external(url: String, richTexts: [RichText]) -> Self {
        let fileType = Block.Icon.External(
            url: URL(string: url)!
        )
        let external = Block.Icon(type: .external(fileType))

        return Self(richTexts: richTexts, icon: external)
    }

    static func emoji(emoji: String, richTexts: [RichText]) -> Self {
        let emoji = Block.Icon(type: .emoji(emoji))

        return Self(richTexts: richTexts, icon: emoji)
    }
}
