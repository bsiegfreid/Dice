import Foundation

// Seedi based on example provided in Swift Argument Parser open source project
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
let seed = UInt64.random(in: UInt64.min ... UInt64.max)
var rng = SplitMix64(seed: UInt64(truncatingIfNeeded: seed))
// End seed

enum DiceError: Error {
    case InvalidInput
}

/// Roll dice.
/// - Parameter rolls: Number of times to roll the dice.
/// - Parameter d: Number of sides of the dice.
/// - Returns: Total of all dice rolls.
public func roll(_ rolls: Int, d: Int) -> Int {
    var result = 0;
    for _ in 1...rolls {
        result += Int.random(in: 1...d, using: &rng)
    }
    return result;
}

/// Roll dice using standard tabletop gaming notation or a range.
/// - Parameter input: A dice roll notation, such as 3d6, or range, such as 1-100
/// - Returns: Total of all dice rolls.
public func roll(_ input: String) throws -> Int {
    
    // This function serves as the first level of input validation
    
    if input.contains("d") {
        return try rollNotation(input)
    } else if input.contains("-") {
        return try rollRange(input)
    } else {
        throw DiceError.InvalidInput
    }
}

/// Roll dice using standard tabletop gaming notation.
/// - Parameter input: A dice roll notation, such as 3d6
/// - Returns: Total of all dice rolls.
private func rollNotation(_ input: String) throws -> Int {
    
    guard input.contains("d") else {
        throw DiceError.InvalidInput
    }
    
    let parts = input.components(separatedBy: "d")

    guard parts.count == 2 else {
        throw DiceError.InvalidInput
    }

    return roll(Int(parts[0])!, d: Int(parts[1])!)
}

/// Return a random number within a range.
/// - Parameter range: A range as a string, such as "1-100"
/// - Returns: An integer within the defined range.
private func rollRange(_ range: String) throws -> Int {
    
    guard range.contains("-") else {
        throw DiceError.InvalidInput
    }
    
    let parts = range.components(separatedBy: "-")

    guard parts.count == 2 else {
        throw DiceError.InvalidInput
    }
    
    guard Int(parts[1])! != Int(parts[0])! else {
        throw DiceError.InvalidInput
    }
    
    var lower = 0
    var upper = 0

    // Allow user to input a reversed range by setting lower to lowest value
    if Int(parts[1])! < Int(parts[0])! {
        lower = Int(parts[1])!
        upper = Int(parts[0])!
    } else {
        lower = Int(parts[0])!
        upper = Int(parts[1])!
    }

    return Int.random(in: lower...upper, using: &rng)
}
