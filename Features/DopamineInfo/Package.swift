// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DopamineInfo",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DopamineInfo",
            type: .static,
            targets: ["DopamineInfo"]
        ),
    ],
    dependencies: [
        .package(path: "../../Dependencies/SenseUI"),
        .package(path: "../../Dependencies/SensePersistence"),
        .package(url: "https://github.com/sorunokoe/ChatGPTService", .branch("main"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DopamineInfo",
            dependencies: [
                .product(name: "SenseUI", package: "SenseUI"),
                .product(name: "SensePersistence", package: "SensePersistence"),
                .product(name: "ChatGPTService", package: "chatgptservice"),
            ]
        ),
        .testTarget(
            name: "DopamineInfoTests",
            dependencies: ["DopamineInfo"]
        ),
    ]
)
