// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DopamineTracker",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DopamineTracker",
            type: .static,
            targets: ["DopamineTracker"]),
    ],
    dependencies: [
        .package(path:  "../../Dependencies/SenseUI"),
        .package(path:  "../../Dependencies/SenseDataSource"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DopamineTracker",
            dependencies: [
                .product(name: "SenseUI", package: "SenseUI"),
                .product(name: "SenseDataSource", package: "SenseDataSource"),
            ]),
        .testTarget(
            name: "DopamineTrackerTests",
            dependencies: ["DopamineTracker"]
        ),
    ]
)
