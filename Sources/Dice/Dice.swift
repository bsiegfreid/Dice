public func roll(_ rolls: Int, d: Int) -> Int {
    var result = 0;
    for _ in 1...rolls {
        result += Int.random(in: 1...d)
    }
    return result;
}
