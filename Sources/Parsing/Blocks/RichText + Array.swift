public extension Array where Element == RichText {
    var text: String {
        map(\.plainText).joined()
    }
}
