import Foundation
import NotionParsing

extension RichText {
    static func text(_ content: String, _ annotations: RichText.Annotations = .normal) -> Self {
        let text = RichText.Types.Text(content: content, link: nil)
        return RichText(type: .text(text), annotations: annotations, plainText: content)
    }

    static func text(_ content: String, _ annotations: RichText.Annotations = .normal, link: String) -> Self {
        let link = RichText.Types.Text.Link(url: URL(string: link)!)
        let text = RichText.Types.Text(content: content, link: link)
        return RichText(type: .text(text), annotations: annotations, plainText: content)
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
