// swift-tools-version:5.5
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
            path: "Sources/",
            resources: [
                .process("lib/rrule.js")
            ]
        )
    ]
)
