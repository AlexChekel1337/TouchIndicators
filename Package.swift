// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TouchIndicators",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "TouchIndicators", targets: ["TouchIndicators"]),
    ],
    targets: [
        .target(name: "TouchIndicators"),
    ]
)
