// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildABuddyKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "BuildABuddyKit", targets: ["BuildABuddyKit"])
    ],
    targets: [
        .target(name: "BuildABuddyKit", resources: [.process("Assets.xcassets")])
    ]
)
