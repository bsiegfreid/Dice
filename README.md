# Dice

Dice is a Swift library that provides functions for rolling dice.

This module is designed for use with the Swift Package Manager. In your `Package.swift` file add a reference to this project:

```swift
let package = Package(
    name: "myapp",
    dependencies: [
        .package(url: "https://github.com/bsiegfreid/Dice", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "myapp",
            dependencies: [

                .product(name: "Dice", package: "Dice"),
            ]),
        .testTarget(
            name: "myapp",
            dependencies: ["myapp"]),
    ]
)
```

Within your Swift module import Dice:

```swift
import Dice
```

You can specify number of rolls and faces. In this example you can roll three six-sided dice:

```swift
let result = roll(3, d:6)
```

You can request a roll within a range. This `throws` to check for invalid range syntax. Range is a starting integer, followed by a dash, with an ending integer. If you input a reversed range, such as `3-1`, then Dice will correct it to allow proper rolling.

```swift
let result = try rollRange("1-4")
```
