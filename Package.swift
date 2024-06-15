// swift-tools-version: 5.9

import PackageDescription
import class Foundation.ProcessInfo

let package = Package(
    name: "swift-notion-parsing",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "NotionParsing",
            targets: ["NotionParsing"]
        )
    ],
    targets: [
        .target(
            name: "NotionParsing",
            dependencies: [
                .product(name: "MacrosInterface", package: "swift-macros")
            ],
            path: "Sources/Parsing"
        ),
        .testTarget(
            name: "NotionParsingTests",
            dependencies: ["NotionParsing"],
            path: "Tests/ParsingTests"
        )
    ]
)

/// Local Development Setup
///
/// We can set `CI_ENVIRONMENT` in `fly.io` to fetch from Remote
if ProcessInfo.processInfo.environment["CI_ENVIRONMENT"] == "YES" {
    package.dependencies += [
        .package(url: "https://github.com/swiftpublished/swift-macros.git", branch: "main")
    ]
} else {
    package.dependencies += [
        .package(path: "../swift-macros")
    ]
}
