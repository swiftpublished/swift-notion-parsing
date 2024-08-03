import Foundation
import NotionParsing

extension Block.Embed {
    static func embed(url: String, caption: [RichText]?) -> Self {

        return Self(url: URL(string: url)!, caption: caption)
    }
}
