struct XorBases {
    var bases: [Int] = []

    mutating func insert(_ x: Int) {
        var x = x
        for y in bases {
            x = min(x, x ^ y)
        }
        if x != 0 {
            bases.append(x)
        }
    }

    mutating func contains(_ x: Int) -> Bool {
        var x = x
        for y in bases {
            x = min(x, x ^ y)
        }
        return x == 0
    }
}