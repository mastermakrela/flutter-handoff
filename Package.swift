// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "handoff",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "handoff", targets: ["handoff"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "handoff",
            dependencies: [],
            path: "ios/Classes"
        )
    ]
)
