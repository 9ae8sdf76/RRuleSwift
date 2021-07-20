// swift-tools-version: 5.0
import PackageDescription

let package = Package(
    name: "RRuleSwift",
    platforms: [.iOS(.v8)],
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
