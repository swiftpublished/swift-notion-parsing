import Foundation
import NotionParsing

extension RichText {
    static func text(_ content: String, _ annotations: RichText.Annotations = .normal) -> Self {
        let text = RichText.Types.Text(content: content, link: nil)
        return RichText(type: .text(text), annotations: annotations, plainText: content, href: nil)
    }

    static func text(_ content: String, _ annotations: RichText.Annotations = .normal, link: String) -> Self {
        let link = RichText.Types.Text.Link(url: URL(string: link)!)
        let text = RichText.Types.Text(content: content, link: link)
        return RichText(type: .text(text), annotations: annotations, plainText: content, href: nil)
    }

    static func mention(_ content: String, _ annotations: RichText.Annotations = .normal, userID: String) -> Self {
        let userMention = RichText.Types.Mention.User(object: "user", id: userID)
        let mention = RichText.Types.Mention(type: .user(userMention))
        return RichText(type: .mention(mention), annotations: annotations, plainText: content, href: nil)
    }

    static func mention(_ content: String, _ annotations: RichText.Annotations = .normal, startDate: String, endDate: String? = nil, timeZone: String? = nil) -> Self {
        let dateMention = RichText.Types.Mention.DateMention(start: startDate, end: endDate, timeZone: timeZone)
        let mention = RichText.Types.Mention(type: .date(dateMention))
        return RichText(type: .mention(mention), annotations: annotations, plainText: content, href: nil)
    }

    static func mention(_ content: String, _ annotations: RichText.Annotations = .normal, pageID: String, href: String) -> Self {
        let pageMention = RichText.Types.Mention.PageMention(id: pageID)
        let mention = RichText.Types.Mention(type: .page(pageMention))
        return RichText(type: .mention(mention), annotations: annotations, plainText: content, href: href)
    }
}

extension RichText.Annotations {
    static var normal: Self {
        Self(
            bold: false,
            italic: false,
            strikethrough: false,
            underline: false,
            code: false
        )
    }

    static var bold: Self {
        Self(
            bold: true,
            italic: false,
            strikethrough: false,
            underline: false,
            code: false
        )
    }

    static var italic: Self {
        Self(
            bold: false,
            italic: true,
            strikethrough: false,
            underline: false,
            code: false
        )
    }

    static var bold_and_italic: Self {
        Self(
            bold: true,
            italic: true,
            strikethrough: false,
            underline: false,
            code: false
        )
    }
}
