infix operator /+: MultiplicationPrecedence // 切り上げ

/// ```
/// assert(5 /+ 2 == 3)
/// assert(6 /+ 2 == 3)
/// assert(-3 /+ 2 == -1)
/// assert(-4 /+ 2 == -2)
/// ```
func /+ (lhs: Int, rhs: Int) -> Int {
    lhs >= 0 ? (lhs + rhs - 1) / rhs : lhs / rhs
}

func testCeilingDivision() {
    assert(0 /+ 3 == 0)
    assert(5 /+ 2 == 3)
    assert(6 /+ 2 == 3)
    assert(-3 /+ 2 == -1)
    assert(-4 /+ 2 == -2)
}

testCeilingDivision()
