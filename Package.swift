// swift-tools-version: 5.3
import PackageDescription

let package = Package(
    name: "RRuleSwift",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "RRuleSwift",
            targets: ["RRuleSwift"]
        ),
    ],
    targets: [
        .target(
            name: "RRuleSwift",
            dependencies: [],
            path: "RRuleSwift/"
        )
    ]
)
