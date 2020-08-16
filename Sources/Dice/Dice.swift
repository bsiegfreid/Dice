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
