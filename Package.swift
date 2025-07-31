// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsFlashNetworking",
    platforms: [
            .iOS(.v14) // Or any other version, like .v14 or .v15
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NewsFlashNetworking",
            targets: ["NewsFlashNetworking"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NewsFlashNetworking"),
        .testTarget(
            name: "NewsFlashNetworkingTests",
            dependencies: ["NewsFlashNetworking"]
        ),
    ]
)
