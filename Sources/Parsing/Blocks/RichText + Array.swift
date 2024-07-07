public extension Array where Element == RichText {
    var plainTexts: String {
        map(\.plainText).joined()
    }
}
