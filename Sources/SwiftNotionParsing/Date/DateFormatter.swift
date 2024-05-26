import Foundation

extension DateFormatter {
    ///
    /// ISO 8601 Date Time string formatter
    ///
    /// eg: 2020-03-17T19:10:04.968Z
    ///
    /// As received for say Notion Page's [last_edited_time](https://developers.notion.com/reference/page#page-object-properties)
    ///
    static let iso8601Notion: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
