// swift-tools-version: 5.10

import PackageDescription

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
    dependencies: [
        .package(path: "../swift-macros")
//        .package(url: "https://github.com/swiftpublished/swift-macros.git", branch: "main")
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
