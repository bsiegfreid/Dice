import Foundation

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
        result += Int.random(in: 1...d)
    }
    return result;
}

/// Return a random number within a range.
/// - Parameter range: A range as a string, such as "1-100"
/// - Returns: An integer within the defined range.
public func rollRange(_ range: String) throws -> Int {
    var result = 0
    var lower = 0
    var upper = 0
    
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
    
    // Allow user to input a reversed range by setting lower to lowest value
    if Int(parts[1])! < Int(parts[0])! {
        lower = Int(parts[1])!
        upper = Int(parts[0])!
    } else {
        lower = Int(parts[0])!
        upper = Int(parts[1])!
    }

    result = Int.random(in: lower...upper)

    return result;
}
