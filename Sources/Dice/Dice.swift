import Foundation

// Seed based on example provided in Swift Argument Parser open source project
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
let seed = UInt64.random(in: UInt64.min ... UInt64.max)
var rng = SplitMix64(seed: UInt64(truncatingIfNeeded: seed))
// End seed

public enum DiceError: Error {
    case InvalidInput
}

/// Roll dice without potential for throwing an exception.
///
/// This version takes explicit integers, avoiding the need for potentially throwing an exception.
///
/// - Parameter rolls: Number of times to roll the dice.
/// - Parameter d: Number of sides of the dice.
/// - Parameter dropLowest: If true the lowest roll will be dropped
/// - Returns: Total of all dice rolls.
public func roll(_ rolls: Int, d: Int, dropLowest: Bool = false) -> Int {
    var results: [Int] = [Int]()
    for _ in 1...rolls {
        results.append(Int.random(in: 1...d, using: &rng))
    }
    if dropLowest {
        results.sort(by: <)
        results.remove(at: 0)
    }
    return results.reduce(0, +);
}

/// Roll dice using standard tabletop gaming notation or a range.
///
/// This version must parse a string which may throw an exception if not properly formed.
///
/// - Parameter input: A dice roll notation, such as 3d6, or range, such as 1-100
/// - Parameter dropLowest: If true the lowest roll will be dropped
/// - Returns: Total of all dice rolls.
/// - Throws: Throws an error if input can't be parsed
public func roll(_ input: String, dropLowest: Bool = false) throws -> Int {
    
    // This function serves as the first level of input validation
    
    if input.contains("d") {
        return try rollNotation(input, dropLowest: dropLowest)
    } else if input.contains("-") {
        return try rollRange(input)
    } else {
        throw DiceError.InvalidInput
    }
}

/// Roll dice using standard tabletop gaming notation.
///
/// This version must parse a string which may throw an exception if not properly formed.
///
/// - Parameter input: A dice roll notation, such as 3d6
/// - Parameter dropLowest: If true the lowest roll will be dropped
/// - Returns: Total of all dice rolls.
/// - Throws: Throws an error if input can't be parsed
private func rollNotation(_ input: String, dropLowest: Bool = false) throws -> Int {
    
    guard input.contains("d") else {
        throw DiceError.InvalidInput
    }
    
    let parts = input.components(separatedBy: "d")

    guard parts.count == 2 else {
        throw DiceError.InvalidInput
    }

    return roll(Int(parts[0])!, d: Int(parts[1])!, dropLowest: dropLowest)
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
