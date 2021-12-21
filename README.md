# Dice

Dice is a Swift library that provides functions for rolling dice and a command line executable. It was created as a sample project using Swift 5.2 and the Swift Package Manager. Part of this exercise was using the GitHub release function. Tag and title the release with a semantic version number, such as v1.2.3, and the Swift Package Manager will be able to pull that release as a dependency into your project directly from GitHub.

This module is designed for use with the Swift Package Manager. In your `Package.swift` file add a reference to this project:

```swift
let package = Package(
    name: "myapp",
    dependencies: [
        .package(url: "https://github.com/bsiegfreid/Dice", from: "0.4.0"),
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

You can request a roll using standard tabletop dice notation or within a range. This `throws` to check for invalid range syntax. Range is a starting integer, followed by a dash, with an ending integer. If you input a reversed range, such as `3-1`, then Dice will correct it to allow proper rolling.

```swift
let result1 = try roll("3d6")
let result2 = try roll("1-4")
```

To build a release version and install:

```bash
swift build --configuration release
cp -f .build/release/roll /usr/local/bin/roll
```

After installation you can roll the dice from the command line:

```bash
roll 3d6
roll 1-100
```

There is now the option to drop the lowest roll:

```bash
roll 4d6 --drop-lowest
```
Version 0.3.0 added the ability to pass a roll modifier when using the notation mode:

```bash
roll 3d6+1
```
