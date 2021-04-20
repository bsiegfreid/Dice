// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dice",
    products: [
        .library(name: "Dice", targets: ["Dice"]),
        .executable(name: "roll", targets: ["roll"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.1"),
    ],
    targets: [
        .target(
            name: "Dice",
            dependencies: []),
        .testTarget(
            name: "DiceTests",
            dependencies: ["Dice"]),
        .target(
            name: "roll",
            dependencies: [
                "Dice",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
    ]
)
