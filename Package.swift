// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "swift-notion-parsing",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftNotionParsing",
            targets: ["SwiftNotionParsing"]
        )
    ],
    dependencies: [
        .package(path: "../swift-macros")
//        .package(url: "https://github.com/swiftpublished/swift-macros.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SwiftNotionParsing",
            dependencies: [
                .product(name: "SwiftMacrosInterface", package: "swift-macros")
            ]
        ),
        .testTarget(
            name: "SwiftNotionParsingTests",
            dependencies: ["SwiftNotionParsing"]
        )
    ]
)
